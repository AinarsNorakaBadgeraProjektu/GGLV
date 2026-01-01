function CreateHand(splitted, bet)
    local self = {};
    self.cards = {};
    self.splitted = not (not splitted);
    self.doubled = false;
    self.bet = bet;
    self.surrendered = false;
    
    self.addCard = function(card)
        table.insert(self.cards, card);

        return self.getValue();
    end

    self.getValue = function()
        local aceCount = 0;
        local count = 0;

        for _, card in pairs(self.cards) do
            local suit, rank = string.split(card, "_");

            if rank == "ace" then
                aceCount += 1;
            end

            count += CardValues[rank];
        end

        if count > 21 then
            for i = 1, aceCount do
                count -= 10;

                if count <= 21 then
                    break;
                end
            end
        end

        return count;
    end

    self.isBlackJack = function()
        return self.getValue() == 21 and #self.cards == 2;
    end

    self.canSplit = function()
        if #self.cards ~= 2 or self.splitted then
            return false;
        end

        local values = {};
        for i = 1, 2 do
            values[i] = GetCardValue(self.cards[i]);
        end

        return values[1] == values[2];
    end

    self.canDouble = function()
        if #self.cards ~= 2 or self.doubled then
            return false;
        end

        return true;
    end

    self.canSurrender = function()
        return #self.cards == 2 and not self.splitted;
    end

    self.setSplitted = function(v)
        self.splitted = v;
    end

    return self
end