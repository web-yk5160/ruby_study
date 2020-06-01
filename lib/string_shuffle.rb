module StringShuffle
  refine String do
    def shuffle
      chars.shuffle.join
    end
  end
end
