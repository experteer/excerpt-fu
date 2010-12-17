class ExcerptFu < String
  
  def self.search(text, substring, options = {})
    new( text ).search( substring, options )
  end

  def search( substring, options = {} )
    @substring = substring
    
    @options = { :omission => '...' }.merge( options )

    if include_substring?
      [ prefix, substring, suffix ].join
    else
      @substring = ''
      [ prefix, suffix ].join
    end
  end

  def self.oniguruma?
    return @@oniguruma if defined? @@oniguruma

    begin
      require 'oniguruma'
      @@oniguruma = true
    rescue LoadError
      @@oniguruma = false
    end
  end


  private
  
  def prefix
    text = full_text_before_substring

    regex = unless ExcerptFu.oniguruma?
      Regexp.new( /^(.*?)(\s*?)(.{0,#{prefix_limit}})$/u )
    else
      Oniguruma::ORegexp.new( "^(.*?)(\s*?)(.{0,#{prefix_limit}})$", "utf8" )
    end
    
    if m = regex.match( text )
      text_before_prefix = !m[1].empty?
      space_before_prefix = !m[2].empty?
      text = m[3] # represents the prefix text

      # now check whether to handle full words
      if full_words? && text_before_prefix && !space_before_prefix
        text.sub!( /^(\w+.?\s*|.?\s*)/iu, "" ) # first word with tailing spaces OR just the tailing spaces
      end

      # apply leading omission if needed
      if text_before_prefix
        text = @options[:omission] + text
      end
    end
    
    text
  end
  
  def suffix
    text = full_text_after_substring


    regex = unless ExcerptFu.oniguruma?
      Regexp.new( /^(.{0,#{suffix_limit}})(\s*?)(.*?)$/u )
    else
      Oniguruma::ORegexp.new( "^(.{0,#{suffix_limit}})(\s*?)(.*?)$", "utf8" )
    end
    
    if m = regex.match( text )
      text = m[1] # represents the suffix text
      space_after_suffix = !m[2].empty?
      text_after_suffix = !m[3].empty?

      # now check whether to handle full words
      if full_words? && text_after_suffix && !space_after_suffix
        text.sub!( /(\s*.?\w+|\s*.?)$/u, "" ) # last word with leading spaces OR just the leading spaces
      end

      # apply tailing omission if needed
      if text_after_suffix
        text += @options[:omission]
      end
    end
    
    text
  end
  
  
  # get everything before the substring or just split in half
  def full_text_before_substring
    if include_substring?
      self.split( @substring )[0] || ""
    else
      self.unpack( "U*" )[ 0..self.unpack( "U*" ).size/2 ].pack( "U*" )
    end
  end
  
  # get everything after the substring or just split in half
  def full_text_after_substring
    if include_substring?
      self.split( @substring )[1] || ""
    else
      self.unpack( "U*" )[ self.unpack( "U*" ).size/2+1..-1 ].pack( "U*" )
    end
  end
  
  # the numbder of characters for the prefix
  def prefix_limit
    limit = ideal_prefix_limit
    
    # extend the limit if the text after the substring is too short
    unless @options[:prefix] || full_text_after_substring_uses_ideal_suffix_limit?
      limit += ideal_suffix_limit - full_text_after_substring.unpack( "U*" ).size
    end
    
    limit
  end
  
  # the numder of characters for the suffix
  def suffix_limit
    limit = ideal_suffix_limit
    
    # extend the limit if the text before the substring is too short
    unless @options[:suffix] || full_text_before_substring_uses_ideal_prefix_limit?
      limit += ideal_prefix_limit - full_text_before_substring.unpack( "U*" ).size
    end
    
    limit
  end
  
  
  def ideal_prefix_limit
    limit = @options[:prefix] || @options[:limit]/2
    
    if !@options[:prefix] && include_substring?
      limit -= @substring.unpack( "U*" ).size/2
    end
    
    limit
  end
  
  def ideal_suffix_limit
    limit = @options[:suffix] || @options[:limit]/2
    
    if !@options[:suffix] && include_substring?
      limit -= @substring.unpack( "U*" ).size/2
    end
    
    limit
  end
  
  # returns whether the full_text_after_substring can use the ideal_suffix_limit
  def full_text_after_substring_uses_ideal_suffix_limit?
    full_text_after_substring.unpack( "U*" ).size >= ideal_suffix_limit
  end
  
  # returns whether the full_text_after_substring can use the ideal_prefix_limit
  def full_text_before_substring_uses_ideal_prefix_limit?
    full_text_before_substring.unpack( "U*" ).size >= ideal_prefix_limit
  end
  
  
  def include_substring?
    !@substring.empty? && self.include?( @substring )
  end
  
  def full_words?; !!@options[:words]; end
  
end

begin
  ActionView::Helpers::TextHelper.module_eval do
    def excerpt_fu(text, phrase, *args)
      ExcerptFu.search(text, phrase, args.extract_options!)
    end
  end
rescue NameError
end
