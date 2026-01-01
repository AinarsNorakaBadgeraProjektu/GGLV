
function CreateGame(id)
    local self = {};
    self.running = false;
    self.started = false;
    self.id = id;
    self.deck = CreateDeck(3, 2);
    self.dealerHand = CreateHand(false, -1);
    self.seats = {};
    self.bets = {};
    self.chips = {};
    self.playerSeats = {}
    self.removePlayers = {}
    self.lastPlayers = {}
    self.pleSeats = {}
    self.lastWon = {}
    self.lastLose = {}
    self.seatsCpy = {}
    self.moneyItem = Config.Tables[id].moneyItem or Config.MoneyItem
    self.addPercent = Config.Tables[id].addPercent or Config.Society.addPercent
    self.removePercent = Config.Tables[id].removePercent or Config.Society.removePercent
    self.preventBust = Config.Tables[id].preventBust ~= nil and Config.Tables[id].preventBust or Config.Society.preventBust
    self.society = (Config.Society.enable) and (Config.Tables[id].society or Config.Society.accountName) or "none"

    self.playerHands = {};
    self.currentPlayer = -1;
    self.currentPlayerHand = -1;

    self.reset = function()
        self.dealerHand = CreateHand(false, -1);

        self.playerHands = {};
        self.seatsCpy = {}
        self.currentPlayer = -1;
        self.currentPlayerHand = -1;
    end

    self.startGame = function()
        self.started = true
        self.lastWon = {}
        self.lastLose = {}
        self.seatsCpy = {}
        self.pleSeats = {}

        for k, v in pairs(self.playerSeats) do
            self.pleSeats[k] = v
        end

        local skipDealer = false;
        local addAmount = 0
        for seat, source in pairs(self.seats) do
            if source then
                if(self.bets[source]) then
                    addAmount += self.bets[source]
                    self.seatsCpy[seat] = source
                    self.playerHands[source] = {CreateHand(false, self.bets[source])};
                end
            end
        end
        if(addAmount > 0 and self.society ~= "none") then
            Bridge.AddSocietyMoney(self.society, math.floor(addAmount * self.addPercent))
        end

        if(Config.RandomDeck) then
            self.deck.reset();
        else
            if self.deck.shouldShuffle() then
                self.deck.reset();
                TriggerClientEvent('sf-blackjack:dealerAnims', -1, self.id, { "deck_shuffle" }, "anim_casino_b@amb@casino@games@threecardpoker@dealer")
                Citizen.Wait(3000)
            end
        end

    
        for i = 1, 2 do
            for j=1,4 do
                local source = self.seatsCpy[j];
                local handArr = self.playerHands[source] or {};

                for _, hand in pairs(handArr) do
                    local playerCard = self.deck.pullCard();
                    local value = hand.addCard(playerCard);

                    if value == 21 then
                        self.handleBlackJack(source, _);
                    elseif value > 21 then
                        self.handleBust(source, _);
                    else
                        DealerSpeech(self.id, "MINIGAME_BJACK_DEALER_"..value)
                    end

                    TriggerClientEvent('sf-blackjack:dealerAnims', -1, self.id, { "deal_card_player_0"..self.pleSeats[source] })
                    TriggerClientEvent("sf-blackjack:spawnCard", -1, self.id, source, playerCard, self.pleSeats[source], i, false, false, false, true)
                    Citizen.Wait(2500)
                    TriggerClientEvent("sf-blackjack:setHands", source, value, 0)
                end
            end

            local dealerCard = self.deck.pullCard();
            self.dealerHand.addCard(dealerCard);

            TriggerClientEvent('sf-blackjack:dealerAnims', -1, self.id, { "deal_card_self"..(i==2 and "_second_card" or "") })
            if i == 1 then
                local fakeDeck = CreateDeck(3, 2)
                TriggerClientEvent("sf-blackjack:spawnCard", -1, self.id, "dealer", fakeDeck.pullCard(), 0, i, false, true, false, true)
            else
                TriggerClientEvent("sf-blackjack:spawnCard", -1, self.id, "dealer", dealerCard, 0, i, false, false, false, true)
            end
            if(i == 2) then
                for seatIndex, source in pairs(self.seatsCpy) do
                    TriggerClientEvent("sf-blackjack:setHands", source, nil, GetCardValue(dealerCard).."?")
                end
            end
            Citizen.Wait(2500)
        end

        do 
            local secDealerCard = GetCardValue(self.dealerHand.cards[2]);
            if secDealerCard == 10 or secDealerCard == 11 then
                if self.dealerHand.getValue() == 21 then
                    TriggerClientEvent('sf-blackjack:dealerAnims', -1, self.id, { "check_and_turn_card" })
                    TriggerClientEvent("sf-blackjack:revealCard", -1, self.id, "dealer", self.dealerHand.cards[1], 1)
                    for seatIndex, source in pairs(self.seatsCpy) do
                        TriggerClientEvent("sf-blackjack:setHands", source, nil, 21)
                    end
                    Citizen.Wait(1000)
                    DealerSpeech(self.id, "MINIGAME_BJACK_DEALER_BLACKJACK")
                    TriggerClientEvent('sf-blackjack:dealerAnims', -1, self.id, { "reaction_good_var_0"..math.random(1, 3) }, "anim_casino_b@amb@casino@games@shared@dealer@")
                    Citizen.Wait(2000);
                    goto skip_player_actions;
                else
                    TriggerClientEvent('sf-blackjack:dealerAnims', -1, self.id, { "check_card" })
                    Citizen.Wait(1700)
                end
            end
        end

        for source, _ in  pairs(self.removePlayers) do
            if(not self.playerSeats[source] or not self.seats[self.playerSeats[source]]) then
                self.removePlayers[source] = nil
                self.playerHands[source] = nil
                TriggerClientEvent("sf-blackjack:removePlayerChips", -1, self.id, source)
                TriggerClientEvent("sf-blackjack:removePlayerCards", -1, self.id, source)
            end
        end

        for j=1,4 do
            local source = self.seatsCpy[j];
            local handArr = self.playerHands[source] or {};
            self.currentPlayer = source;
            self.handlePlayerHands(source, handArr)
        end

        Citizen.Wait(1500);

        do 
            local foundValidHand = false;
            for source, handArr in pairs(self.playerHands) do
                for _, hand in pairs(handArr) do
                    if hand.getValue() < 21 and not hand.surrendered then
                        foundValidHand = true;
                    end
                end
            end

            if not foundValidHand then
                skipDealer = true;
            end
        end

        TriggerClientEvent('sf-blackjack:dealerAnims', -1, self.id, { "turn_card" })
        TriggerClientEvent("sf-blackjack:revealCard", -1, self.id, "dealer", self.dealerHand.cards[1], 1)
        Citizen.Wait(1500)

        ::skip_player_actions::
        local value = self.dealerHand.getValue();
        Citizen.Wait(500);
        for seatIndex, source in pairs(self.seatsCpy) do
            TriggerClientEvent("sf-blackjack:setHands", source, nil, value)
        end
        while value < 17 and not skipDealer do 
            local dealerCard = self.deck.pullCard();
            TriggerClientEvent('sf-blackjack:dealerAnims', -1, self.id, { "deal_card_self_second_card" })
            TriggerClientEvent("sf-blackjack:spawnCard", -1, self.id, "dealer", dealerCard, 0, #self.dealerHand.cards+1, false, false, false, true)
            Citizen.Wait(1250)
            value = self.dealerHand.addCard(dealerCard);
            DealerSpeech(self.id, "MINIGAME_BJACK_DEALER_"..value)
            for seatIndex, source in pairs(self.seatsCpy) do
                TriggerClientEvent("sf-blackjack:setHands", source, nil, value)
            end
        end

        if value > 21 then
            TriggerClientEvent('sf-blackjack:dealerAnims', -1, self.id, { "reaction_bad_var_0"..math.random(1, 3) }, "anim_casino_b@amb@casino@games@shared@dealer@")
            DealerSpeech(self.id, "MINIGAME_DEALER_BUSTS")
            Citizen.Wait(2000)
        end

        local removeAmount = 0
        for source, handArr in pairs(self.playerHands) do
            for _, hand in pairs(handArr) do
                local handValue = hand.getValue();
                if hand.surrendered or handValue > 21 then 
                    goto end_hand_continue;
                end

                if value > 21 and handValue <= 21 then
                    if hand.isBlackJack() then
                        removeAmount += math.floor(hand.bet * (5/2))
                        Bridge.AddItem(source, self.moneyItem, math.floor(hand.bet * (5/2)));
                        self.lastWon[source] = true
                    else
                        removeAmount += hand.bet*2
                        Bridge.AddItem(source, self.moneyItem, hand.bet*2);
                        self.lastWon[source] = true
                        PlayerReaction(source, "great")
                    end

                    goto end_hand_continue;
                end

                if handValue > value then
                    if hand.isBlackJack() then
                        removeAmount += math.floor(hand.bet * (5/2))
                        Bridge.AddItem(source, self.moneyItem, math.floor(hand.bet * (5/2)));
                        self.lastWon[source] = true
                    else
                        removeAmount += hand.bet*2
                        Bridge.AddItem(source, self.moneyItem, hand.bet*2);
                        self.lastWon[source] = true
                        PlayerReaction(source, "great")
                    end

                    goto end_hand_continue;
                end

                if handValue < value then
                    PlayerReaction(source, "bad")
                    self.lastLose[source] = true
                end

                if handValue == value then
                    if hand.isBlackJack() and not self.dealerHand.isBlackJack() then
                        removeAmount += math.floor(hand.bet * (5/2))
                        Bridge.AddItem(source, self.moneyItem, math.floor(hand.bet * (5/2)));
                        self.lastWon[source] = true
                    elseif not hand.isBlackJack() and self.dealerHand.isBlackJack() then
                        PlayerReaction(source, "bad")
                        self.lastLose[source] = true
                    else
                        removeAmount += hand.bet
                        Bridge.AddItem(source, self.moneyItem, hand.bet);
                        PlayerReaction(source, "impartial")
                        self.lastWon[source] = true
                    end
                end
                ::end_hand_continue::
            end
        end

        if(self.society ~= "none" and removeAmount > 0) then
            Bridge.RemoveSocietyMoney(self.society, math.floor(removeAmount * self.removePercent))
        end
        
        self.bets = {}
        for i=1, 4 do
            if(self.seatsCpy[i] and self.playerHands[self.seatsCpy[i]]) then
                TriggerClientEvent('sf-blackjack:dealerAnims', -1, self.id, { "retrieve_cards_player_0"..i })
                Citizen.Wait(800)
                TriggerClientEvent("sf-blackjack:removePlayerCards", -1, self.id, self.seatsCpy[i])
                TriggerClientEvent("sf-blackjack:removePlayerChips", -1, self.id, self.seatsCpy[i])
                Citizen.Wait(300)
            end
        end

        TriggerClientEvent('sf-blackjack:dealerAnims', -1, self.id, { "retrieve_own_cards_and_remove" })
        Citizen.Wait(1200)
        TriggerClientEvent("sf-blackjack:removePlayerCards", -1, self.id, "dealer")
        Citizen.Wait(1000)
        TriggerClientEvent('sf-blackjack:dealerAnims', -1, self.id, { GetDealerIdle(self.id) }, "anim_casino_b@amb@casino@games@shared@dealer@")
        self.time = os.time()
        self.started = false
        self.reset()
        DealerSpeech(self.id, "MINIGAME_DEALER_ANOTHER_GO")
        for seatIndex, source in pairs(self.seats) do
            TriggerClientEvent("sf-blackjack:gameEnd", source)
			TriggerClientEvent('sf-blackjack:timeLeft', source, Config.PrepareTime)
		end
    end

    self.handlePlayerHands = function(source, handArr)
        for _, hand in pairs(handArr) do
            if hand.getValue() >= 21 or hand.surrendered then
                goto hand_continue;
            end

            TriggerClientEvent('sf-blackjack:dealerAnims', -1, self.id, { "dealer_focus_player_0"..self.pleSeats[source].."_idle_intro"..(_ == 2 and "_split" or "")})
            Citizen.Wait(1500)
            TriggerClientEvent('sf-blackjack:dealerAnims', -1, self.id, { "dealer_focus_player_0"..self.pleSeats[source].."_idle"..(_ == 2 and "_split" or "")})
            DealerSpeech(self.id, "MINIGAME_BJACK_DEALER_ANOTHER_CARD")
            TriggerClientEvent("sf-blackjack:setHands", source, hand.getValue())
            self.currentPlayerHand = _;
            local hitting = true;

            while hitting do
                local canDouble = hand.canDouble() and Bridge.GetItemCount(source, self.moneyItem) >= hand.bet;
                local canSplit = hand.canSplit() and Bridge.GetItemCount(source, self.moneyItem) >= hand.bet;
                local canSurrender = hand.canSurrender();
                local action
                if(not self.playerSeats[source]) then
                    hitting = false;
                    goto action_continue
                end
                action = TriggerClientCallback("sf-blackjack:requestInteraction", source, canSplit, canDouble, canSurrender) or 'stand';

                if action == "surrendered" then
                    TriggerClientEvent("sf-blackjack:playerAnims", source, { "decline_card_alt1" })
                    Citizen.Wait(700);
                    hitting = false;
                    hand.surrendered = true;
                    Bridge.AddItem(source, self.moneyItem, math.floor(hand.bet/2));
                    goto action_continue;
                end

                if(action == "stand") then
                    TriggerClientEvent("sf-blackjack:playerAnims", source, { "decline_card_001" })
                    Citizen.Wait(700);
                    hitting = false;
                    goto action_continue; 
                end

                if(action == "hit") then
                    TriggerClientEvent("sf-blackjack:playerAnims", source, { "request_card" })
                    Citizen.Wait(700);

                    local playerCard = self.deck.pullCard();
                    local value = hand.addCard(playerCard);
                    TriggerClientEvent('sf-blackjack:dealerAnims', -1, self.id, { "hit_"..(_ == 2 and "second_" or "").."card_player_0"..self.pleSeats[source]})
                    TriggerClientEvent("sf-blackjack:spawnCard", -1, self.id, source, playerCard, self.pleSeats[source], #hand.cards, _ == 2, false, false, true)
                    Citizen.Wait(1500);
                    TriggerClientEvent("sf-blackjack:setHands", source, hand.getValue())
                    if value == 21 then
                        self.handleBlackJack(source, _);
                        hitting = false;
                    elseif value > 21 then
                        self.handleBust(source, _);
                        hitting = false;
                    else
                        DealerSpeech(self.id, "MINIGAME_BJACK_DEALER_"..value)
                    end
                    TriggerClientEvent('sf-blackjack:dealerAnims', -1, self.id, { "dealer_focus_player_0"..self.pleSeats[source].."_idle"..(_ == 2 and "_split" or "")})
                    goto action_continue;
                end

                if(action == "double") then
                    hitting = false;
                    if Bridge.GetItemCount(source, self.moneyItem) < hand.bet or not hand.canDouble() then
                        goto action_continue;
                    end

                    if not Bridge.RemoveItem(source, self.moneyItem, hand.bet) then
                        goto action_continue;
                    end
                    if(self.society ~= "none") then
                        Bridge.AddSocietyMoney(self.society, math.floor(hand.bet * self.addPercent))
                    end
                    if(_ == 2) then
                        TriggerClientEvent("sf-blackjack:playerAnims", source, { "place_bet_double_down" })
                    else
                        TriggerClientEvent("sf-blackjack:playerAnims", source, { "place_bet_small" })
                    end
                    Citizen.Wait(700);
                    TriggerClientEvent("sf-blackjack:spawnChip", -1, self.id, GetBetIdFromAmount(hand.bet), self.pleSeats[source], source, (_ == 2) and 4 or 2)
                    hand.doubled = true;
                    hand.bet *= 2;

                    local playerCard = self.deck.pullCard();
                    local value = hand.addCard(playerCard);
                    TriggerClientEvent('sf-blackjack:dealerAnims', -1, self.id, { "hit_"..(_ == 2 and "second_" or "").."card_player_0"..self.pleSeats[source]})
                    TriggerClientEvent("sf-blackjack:spawnCard", -1, self.id, source, playerCard, self.pleSeats[source], #hand.cards, _ == 2, false, true, true)
                    Citizen.Wait(1000);
                    TriggerClientEvent("sf-blackjack:setHands", source, hand.getValue())

                    if value == 21 then
                        self.handleBlackJack(source, _);
                    elseif value > 21 then
                        self.handleBust(source, _);
                    else
                        DealerSpeech(self.id, "MINIGAME_BJACK_DEALER_"..value)
                    end
                    goto action_continue;
                end

                if(action == "split") then
                    hitting = false;
                    if Bridge.GetItemCount(source, self.moneyItem) < hand.bet or not hand.canSplit() then
                        goto action_continue;
                    end
                
                    if not Bridge.RemoveItem(source, self.moneyItem, hand.bet) then
                        goto action_continue;
                    end
                    if(self.society ~= "none") then
                        Bridge.AddSocietyMoney(self.society, math.floor(hand.bet * self.addPercent))
                    end
                    hand.setSplitted(true);
                    TriggerClientEvent("sf-blackjack:playerAnims", source, { "place_bet_small_split" })
                    Citizen.Wait(700)
                    TriggerClientEvent("sf-blackjack:spawnChip", -1, self.id, GetBetIdFromAmount(hand.bet), self.pleSeats[source], source, 3)
                    local secCard = table.remove(hand.cards);
                    local splitHand = CreateHand(true, hand.bet);
                    splitHand.addCard(secCard);
                    table.insert(handArr, splitHand);
                    TriggerClientEvent('sf-blackjack:dealerAnims', -1, self.id, { "split_card_player_0"..self.playerSeats[source]})
                    TriggerClientEvent("sf-blackjack:changeToSplit", -1, self.id, source, secCard, self.playerSeats[source], #hand.cards+1)
                    Citizen.Wait(1000)
                    TriggerClientEvent("sf-blackjack:setHands", source, hand.getValue())

                    return self.handlePlayerHands(source, handArr);
                end
            
                ::action_continue::
                Citizen.Wait(0); -- for safety
            end

            ::hand_continue::
        end
    end

    self.handleBlackJack = function(source, hand)

        local isBlackJack = self.playerHands[source][hand].isBlackJack();
        if isBlackJack then
            DealerSpeech(self.id, "MINIGAME_BJACK_DEALER_BLACKJACK")
        else
            DealerSpeech(self.id, "MINIGAME_BJACK_DEALER_21")
        end
        PlayerReaction(source, "great")
    end

    self.handleBust = function(source, hand)
        self.lastLose[source] = true
        DealerSpeech(self.id, "MINIGAME_BJACK_DEALER_PLAYER_BUST")
        PlayerReaction(source, "terrible")
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
    if(BlackjackSources[source]) then
        TriggerClientEvent("sf-blackjack:playerAnims", source, { "reaction_"..reactionType.."_var_0"..math.random(1, 4) }, "anim_casino_b@amb@casino@games@shared@player@") 
    end
end