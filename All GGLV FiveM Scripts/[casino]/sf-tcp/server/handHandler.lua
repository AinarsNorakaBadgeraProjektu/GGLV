local importance    = {"isStraightFlush", 'isThreeOfAKind', 'isStraight', 'isFlush', 'isPair'};
local anteBonuses   = {5, 4, 1, 0, 0};
local pairsPlus     = {40, 30, 6, 4, 1};

function CreateHand(splitted) -- ALL OF THIS ASSUMES THREE CARDS BTW, SO ITS NOT EXTENDABLE TO 5 CARD POKER I.E.
    local self = {};
    self.cards = {};
    self.splitted = not (not splitted);
    self.doubled = false;
    self.surrendered = false;
    
    self.addCard = function(card)
        table.insert(self.cards, card);
    end

    self.compareHands = function(opponentHand)
        for _, key in pairs(importance) do
            local myC, myCv = self[key]();
            local opC, opCv = opponentHand[key]();

            if myC ~= opC then
                return myC, false;
            elseif myC and myCv ~= opCv then
                return myCv > opCv, false; 
            end
        end

        -- If no figures found then compare cards
        local myValues = self.getValues();
        local opValues = opponentHand.getValues();
        for i = #myValues, 1, -1 do
            local myV = myValues[i]; 
            local opV = opValues[i]; 

            if myV ~= opV then
                return myV > opV, false;
            end
        end

        -- If there are no differences hands are equal
        return false, true;
    end

    self.getAnteBonus = function()
        for i, key in pairs(importance) do
            if self[key]() then
                return anteBonuses[i];
            end
        end

        return 0;
    end

    self.getPairsPayout = function()
        for i, key in pairs(importance) do
            if self[key]() then
                return pairsPlus[i];
            end
        end

        return 0;
    end

    self.getHighCard = function()
        local values = self.getValues();

        return values[#values];
    end

    self.isPair = function()
        local values = self.getValues();

        for i = 1, #values-1 do
            if values[i] == values[i+1] then
                return true, values[i];
            end
        end

        return false, -1;
    end

    self.isFlush = function()
        local suits = self.getSuits();
        local suit = suits[1];

        for i=2, #suits do
            if suits[i] ~= suit then
                return false, -1;
            end
        end

        return true, 0;
    end

    self.isStraight = function()
        local values = self.getValues();

        -- This is stupid but its late, i don't have better ideas...
        -- Check with ace as 14
        if values[1] + 1 == values[2] and values[1] + 2 == values[3] then
            return true, values[3];
        end
        
        -- Check with ace as 1
        if values[3] == 14 and values[1] == 2 and values[2] == 3 then
            return true, values[2];
        end

        return false, 0;
    end

    self.isThreeOfAKind = function()
        local values = self.getValues();
        local value = values[1]; 

        for i=2, #values do
            if values[i] ~= value then
                return false, -1;
            end
        end

        return true, value;
    end

    self.isStraightFlush = function()
        local isStraight, value = self.isStraight();

        return isStraight and self.isFlush(), value;
    end

    self.getValues = function()
        local values = {};
       
        for _, card in pairs(self.cards) do
            local value = GetCardValue(card);
            table.insert(values, value);
        end

        table.sort(values);

        return values;
    end

    self.getSuits = function()
        local suits = {};

        for _, card in pairs(self.cards) do
            local _,suit = GetCardValue(card);
            table.insert(suits, suit);
        end

        return suits;
    end

    self.isPairOrBetter = function()
        return self.isPair() or self.isStraight() or self.isFlush() or self.isThreeOfAKind();
    end

    return self
end

RegisterCommand("testHands", function(_, args)
    local hand1 = CreateHand();
    local hand2 = CreateHand();

    for i = 1, 3 do
        hand1.addCard(args[i]);
    end
    for i = 4, 6 do
        hand2.addCard(args[i]);
    end

    print("OUTCOME: ", hand1.compareHands(hand2))
end)