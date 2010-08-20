class ExcerptFu < String

  attr_accessor :substring, :prefix_size, :suffix_size, :full_words

  def self.search(text, substring, options = {})
    new(text).search(substring, options)
  end

  def search(substring, options = {})
    @substring = substring
    extract_options(options)

    if self.include?(substring)
      [ prefix, substring, suffix ].join
    else
      self[size/2-prefix_size..size/2+suffix_size]
    end
  end

  private

    def prefix
      if full_words && prefix_first_word_incomplete?
        prefix_raw.gsub(/^(\w+.?){1}/, "")
      else
        prefix_raw
      end
    end

    def prefix_first_word_incomplete?
      prefix_start > 0 && prefix_str[prefix_start-1] != " "
    end

    def prefix_raw
      prefix_str[prefix_start..-1]
    end

    def suffix
      if full_words && suffix_last_word_incomplete?
        suffix_raw.gsub(/(\w+.?){1}$/, "").rstrip
      else
        suffix_raw
      end
    end

    def suffix_last_word_incomplete?
      suffix_end < suffix_str.size-1 && suffix_str[suffix_end+1] != " "
    end

    def suffix_raw
      suffix_str[0..suffix_end]
    end

    def extract_options(options)
      @prefix_size = options[:prefix]
      @suffix_size = options[:suffix]
      @full_words = options[:words]
    end

    def prefix_start_raw
      prefix_str.size - prefix_size
    end

    def prefix_start
      prefix_start = [prefix_start_raw, 0].max

      if suffix_str.size >= suffix_size
        prefix_start
      else
        prefix_start = prefix_start - (suffix_size - suffix_str.size)
      end

      [prefix_start, 0].max
    end

    def suffix_end_raw
      suffix_size - 1
    end

    def suffix_end
      if prefix_start_raw > 0
        suffix_end_raw
      else
        suffix_end_raw - prefix_start_raw
      end
    end

    def prefix_str
      self.split(substring)[0]
    end

    def suffix_str
      self.split(substring)[1] || ""
    end

end

begin
  ActionView::Helpers::TextHelper.module_eval do
    def excerpt_fu(text, phrase, *args)
      ExcerptFu.search(text, phrase, args.extract_options!)
    end
  end
rescue NameError
end
