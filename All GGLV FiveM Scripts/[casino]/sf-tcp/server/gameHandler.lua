function CreateGame(id)
    local self = {};
    self.running = false;
    self.started = false;
    self.id = id;
    self.deck = CreateDeck(1, 0);
    self.dealerHand = CreateHand(false, -1);
    self.seats = {};
    self.chips = {};
    self.pairBets = {};
    self.anteBets = {};
    self.playerSeats = {}
    self.removePlayers = {}
    self.lastPlayers = {}
    self.lastWon = {}
    self.lastLose = {}
    self.seatsCpy = {}
    self.pleSeats = {}
    self.addPercent = Config.Tables[id].addPercent or Config.Society.addPercent
    self.removePercent = Config.Tables[id].removePercent or Config.Society.removePercent
    self.preventBust = Config.Tables[id].preventBust ~= nil and Config.Tables[id].preventBust or Config.Society.preventBust
    self.society = (Config.Society.enable) and (Config.Tables[id].society or Config.Society.accountName) or "none"
    self.moneyItem = Config.Tables[id].moneyItem or Config.MoneyItem

    self.playerHands = {};

    self.reset = function()
        self.dealerHand = CreateHand(false, -1);

        self.playerHands = {};
        self.pairBets = {}
        self.anteBets = {}
        self.pleSeats = {}
        self.deck.reset();
    end

    self.startGame = function()
        self.lastWon = {}
        self.lastLose = {}
        self.seatsCpy = {}
        self.pleSeats = {}

        for k, v in pairs(self.playerSeats) do
            self.pleSeats[k] = v
        end

        local addAmount = 0
        for seat, source in pairs(self.seats) do
            if source and (self.pairBets[source] or self.anteBets[source]) then
                self.seatsCpy[seat] = source
                self.playerHands[source] = CreateHand(false);
                TriggerClientEvent("sf-tcp:hideTop", source)
                addAmount += self.pairBets[source] or 0
                addAmount += self.anteBets[source] or 0
            end
        end
        if(self.society ~= "none") then
            Bridge.AddSocietyMoney(self.society, math.floor(addAmount * self.addPercent))
        end

        self.started = true
        self.deck.shuffle();
        TriggerClientEvent("sf-tcp:dealerAnims", -1, self.id, { "deck_pick_up" })
        Citizen.Wait(2000)
        TriggerClientEvent("sf-tcp:dealerAnims", -1, self.id, { "deck_shuffle" })
        Citizen.Wait(3000)


        for j=1,4 do
            local source = self.seatsCpy[j];
            local hand = self.playerHands[source];

            if hand then
                local playerCards = {};
                for i = 1, 3 do
                    local card = self.deck.pullCard(); 
                    table.insert(playerCards, card);
                    hand.addCard(card);
                end
                TriggerClientEvent("sf-tcp:dealerAnims", -1, self.id, { "deck_deal_p0"..j })
                TriggerClientEvent("sf-tcp:spawnCards", -1, self.id, source, j, playerCards)
                Citizen.Wait(3000)
            end
        end

        do 
            local dealerCards = {};
            for i = 1, 3 do
                local card = self.deck.pullCard();
                table.insert(dealerCards, card);
                self.dealerHand.addCard(card);
            end
            TriggerClientEvent("sf-tcp:dealerAnims", -1, self.id, { "deck_deal_self", "deck_idle" })
            TriggerClientEvent("sf-tcp:spawnCards", -1, self.id, "dealer", 0, dealerCards, "deck_deal_self")
            Citizen.Wait(4000)
        end
        
        for source, _ in  pairs(self.removePlayers) do
            if(not self.playerSeats[source] or not self.seats[self.playerSeats[source]]) then
                self.removePlayers[source] = nil
                self.playerHands[source] = nil
                TriggerClientEvent("sf-tcp:removePlayerChips", -1, self.id, source)
                TriggerClientEvent("sf-tcp:removePlayerCards", -1, self.id, source)
            end
        end

        for j=1,4 do
            local source = self.seatsCpy[j];
            local hand = self.playerHands[source];

            if hand then
                TriggerClientEvent("sf-tcp:playCardsAnim", -1, self.id, source, j, "cards_pickup")
                TriggerClientEvent("sf-tcp:playerAnims", source, { "cards_pickup", "cards_idle" })
                Citizen.SetTimeout(2000, function()
                    TriggerClientEvent("sf-tcp:playCardsAnim", -1, self.id, source, j, "cards_idle", nil, true)
                end)
            end
        end
        Citizen.Wait(4000)

        local responses = {};
        for source, _ in pairs(self.playerHands) do
            local placedAnteBet = not not self.anteBets[source];
            local value = nil;
            if not placedAnteBet then value = false end
            responses[source] = { antePlay = value };

            if placedAnteBet then
                Citizen.CreateThread(function()
                    
                    local resp
                    if(not self.playerSeats[source]) then
                        resp = false
                        responses[source].antePlay = resp;
                        return
                    end
                    resp = TriggerClientCallback("sf-tcp:requestAction", source);

                    if resp and Bridge.GetItemCount(source, self.moneyItem) < self.anteBets[source] then
                        ShowNotification(source, _L("not_enough_money"))
                        resp = false;
                    end

                    if resp then
                        if(self.society ~= "none") then
                            Bridge.AddSocietyMoney(self.society, math.floor(self.anteBets[source] * self.addPercent))
                        end
                        Bridge.RemoveItem(source, self.moneyItem, self.anteBets[source]);
                        TriggerClientEvent("sf-tcp:playCardsAnim", -1, self.id, source, self.pleSeats[source], "cards_play", nil, false)
                        TriggerClientEvent("sf-tcp:playerAnims", source, { "cards_play" })
                        Citizen.SetTimeout(1000, function()
                            TriggerClientEvent("sf-tcp:spawnChip", -1, self.id, GetBetIdFromAmount(self.anteBets[source]), self.pleSeats[source], source, 3)
                        end)
                        Citizen.Wait(3000)
                    else
                        TriggerClientEvent("sf-tcp:playCardsAnim", -1, self.id, source, self.pleSeats[source], "cards_fold", nil, false)
                        TriggerClientEvent("sf-tcp:playerAnims", source, { "cards_fold" })
                        Citizen.Wait(3000)
                    end

                    responses[source].antePlay = resp;
                end)
            end
        end

        local timeout = 35000;
        local startTime = GetGameTimer();
        while true do
            Citizen.Wait(100);

            local foundNil = false;
            for _, response in pairs(responses) do
                if response.antePlay == nil then
                    foundNil = true;
                    break;
                end
            end

            if not foundNil then
                break;
            end

            if GetGameTimer() - startTime > timeout then
                break;
            end
        end

        TriggerClientEvent("sf-tcp:playCardsAnim", -1, self.id, "dealer", nil, "reveal_self", "anim_casino_b@amb@casino@games@threecardpoker@dealer", false, 0)
        TriggerClientEvent("sf-tcp:dealerAnims", -1, self.id, { "reveal_self" })
        Citizen.Wait(3000);
        local dealerQueenOrHigher = self.dealerHand.getHighCard() >= 12 or self.dealerHand.isPairOrBetter();
        if(not dealerQueenOrHigher) then
            TriggerClientEvent('sf-tcp:dealerAnims', -1, self.id, { "reaction_impartial_var_0"..math.random(1, 3) }, "anim_casino_b@amb@casino@games@shared@dealer@")
            Citizen.Wait(2000)
        end

        for j=1,4 do
            local source = self.seatsCpy[j];
            local hand = self.playerHands[source];

            if hand then
                TriggerClientEvent("sf-tcp:playCardsAnim", -1, self.id, source, nil, "reveal_"..(responses[source].antePlay and "played" or "folded").."_p0"..j, "anim_casino_b@amb@casino@games@threecardpoker@dealer", false, j)
                TriggerClientEvent("sf-tcp:dealerAnims", -1, self.id, { "reveal_"..(responses[source].antePlay and "played" or "folded").."_p0"..j })
                Citizen.Wait(3000)
            end
        end
    
        local playerReactions = {}
        local anyStraightFlush = false
        local removeMoney = 0
        for source, hand in pairs(self.playerHands) do
            local placedAnteBet = not not self.anteBets[source];
            local placedPairBet = not not self.pairBets[source];

            if placedAnteBet and responses[source].antePlay then
                if(hand.isStraightFlush()) then
                    anyStraightFlush = true
                end
                if not dealerQueenOrHigher then
                    removeMoney += 2 * self.anteBets[source]
                    Bridge.AddItem(source, self.moneyItem, 2 * self.anteBets[source]);
                    playerReactions[source] = "impartial"
                else
                    local better, equal = hand.compareHands(self.dealerHand);

                    if better then
                        removeMoney += 3 * self.anteBets[source]
                        Bridge.AddItem(source, self.moneyItem, 3 * self.anteBets[source]);
                        playerReactions[source] = "good"
                        self.lastWon[source] = true
                    elseif equal then
                        Bridge.AddItem(source, self.moneyItem, 2 * self.anteBets[source]);
                        playerReactions[source] = "impartial"
                    end

                    local bonus = hand.getAnteBonus();
                    if bonus > 0 then
                        removeMoney += bonus * self.anteBets[source]
                        Bridge.AddItem(source, self.moneyItem, bonus * self.anteBets[source]);
                        playerReactions[source] = "great"
                        self.lastWon[source] = true
                    end
                end
            end
        
            if placedAnteBet and placedPairBet then
                local payout = hand.getPairsPayout()

                if payout > 0 then
                    removeMoney += (payout+1) * self.pairBets[source]
                    Bridge.AddItem(source, self.moneyItem, (payout+1) * self.pairBets[source]);
                    playerReactions[source] = "good"
                    self.lastWon[source] = true
                end
            end

            if(not playerReactions[source] and self.anteBets[source]) then
                if(self.anteBets[source] > 1000) then
                    playerReactions[source] = "terrible"
                else
                    playerReactions[source] = "bad"
                end
                self.lastLose[source] = true
            end
        end

        if(self.society ~= "none" and removeMoney > 0) then
            Bridge.RemoveSocietyMoney(self.society, math.floor(removeMoney * self.removePercent))
        end

        if(anyStraightFlush) then
            TriggerEvent("sf-casinoutils:playAnnounce", "straight_flush_win")
        end

        self.pairBets = {}
        self.anteBets = {}

        for j=1,4 do
            local source = self.seatsCpy[j];
            local hand = self.playerHands[source];
            
            if hand then
                Citizen.CreateThread(function()
                    if(playerReactions[source] == "great" or playerReactions == "good") then
                        PlayerReaction(source, playerReactions[source])
                        Citizen.Wait(2000)
                        TriggerClientEvent("sf-tcp:playerAnims", source, { "collect_chips" })
                    elseif(playerReactions[source] ~= nil) then
                        PlayerReaction(source, playerReactions[source])
                    end
                end)
                Citizen.SetTimeout(700, function()
                    TriggerClientEvent("sf-tcp:removePlayerChips", -1, self.id, source)
                end)
                TriggerClientEvent("sf-tcp:playCardsAnim", -1, self.id, source, nil, "cards_collect_p0"..j, "anim_casino_b@amb@casino@games@threecardpoker@dealer", false, j)
                TriggerClientEvent("sf-tcp:dealerAnims", -1, self.id, { "cards_collect_p0"..j })
                Citizen.Wait(1700)
                TriggerClientEvent("sf-tcp:removePlayerCards", -1, self.id, source)
            end
        end
        Citizen.Wait(700)
        TriggerClientEvent("sf-tcp:playCardsAnim", -1, self.id, "dealer", nil, "cards_collect_self", "anim_casino_b@amb@casino@games@threecardpoker@dealer", false, 0)
        TriggerClientEvent("sf-tcp:dealerAnims", -1, self.id, { "cards_collect_self" })
        Citizen.Wait(1700)
        TriggerClientEvent("sf-tcp:removePlayerCards", -1, self.id, "dealer")
        TriggerClientEvent("sf-tcp:dealerAnims", -1, self.id, { "deck_put_down" })
        Citizen.Wait(1500)
        TriggerClientEvent("sf-tcp:dealerAnims", -1, self.id, { GetDealerIdle(self.id) }, "anim_casino_b@amb@casino@games@shared@dealer@")
        self.time = os.time()
        self.started = false
        self.reset()
        DealerSpeech(self.id, "MINIGAME_DEALER_ANOTHER_GO")
        for seatIndex, source in pairs(self.seats) do
            TriggerClientEvent("sf-tcp:gameEnd", source)
			TriggerClientEvent('sf-tcp:timeLeft', source, Config.PrepareTime)
		end
        Citizen.Wait(700)
        TriggerClientEvent('sf-tcp:dealerAnims', -1, self.id, { GetDealerIdle(self.id) }, "anim_casino_b@amb@casino@games@shared@dealer@")
    end

    self.handleExit = function(source)
        if(self.pleSeats[source]) then
            self.removePlayers[source] = true
        end
    end

    return self
end

function GetBetIdFromAmount(amount)
    for i=1, #Bets do
        if(Bets[i] == amount) then
            return i
        end
    end
end

function PlayerReaction(source, reactionType)
    if(TcpSources[source] and reactionType) then
        TriggerClientEvent("sf-tcp:playerAnims", source, { "reaction_"..reactionType.."_var_0"..math.random(1, 4) }, "anim_casino_b@amb@casino@games@shared@player@") 
    end
end