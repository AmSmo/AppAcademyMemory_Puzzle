class Card
    attr_accessor :value, :face_up
    def initalize
        @value = :O
        @face_up = false
    end
    
    def hide
        @face_up = false
    end

    def reveal
        @face_up = true
    end
end