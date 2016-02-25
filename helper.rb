module Helper
  # Sort Hashes in descending frequencing

  def self.remove_stop_words(tweets_words)
    tweets = tweets_words
    stop_words = []
    File.open("stop_words.json", "r").each do |x|
      stop_words << x
    end
    stop_words = stop_words.join(" ").split(",")
    stop_words_free = []
    tweets.each do |word|
      if stop_words.include?word
        nil
      else
        stop_words_free << word
      end
    end
    stop_words_free.join(" ")
  end

  def self.sort_hash_descend(value)
    sorted_hash = Hash.new
    value.sort_by { |_x, y| -y }.each do |val|
      sorted_hash[val[0]] = val[1]
    end
    sorted_hash
  end

  # Counts the occurence of words in a string and returns 'word => frequency'
  def self.words_counter(words)
    word_list = words.split(" ")
    word_map = Hash.new
    word_list.each do |word|
      word.downcase!
      next unless word.length > 2
      if word_map.key?(word)
        word_map[word] += 1
      else
        word_map[word] = 1
      end
    end
    word_map
  end

  def self.rank_words(okay_words)
    Helper.sort_hash_descend(Helper.words_counter(okay_words))
  end

  def self.display_ranking(ranked_words)
    longest_key = ranked_words.keys.max_by(&:length)
    longest_key.length.times { print "-" }
    print "----------------\n"
    printf "| %-#{longest_key.length}s | %-9s |\n", "Word", "Frequency"
    longest_key.length.times { print "-" }
    print "----------------\n"
    ranked_words.each do |key, value|
      printf "| %-#{longest_key.length}s |    %-6s |\n", key, value
    end
    longest_key.length.times { print "-" }
    print "----------------\n"
  end
end
