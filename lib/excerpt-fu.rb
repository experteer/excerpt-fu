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


  private
  
  def prefix
    text = full_text_before_substring
    
    # now only cut out the needed chars
    text = text.split( //u ).reverse[0, prefix_limit].reverse.join
    
    # now check whether to handle full words
    prefix_start_index = self.index( text )
    if full_words? && 
      prefix_start_index > 0 && self.split( //u )[ prefix_start_index-1 ] != " "
      
      text = text.sub( /^(\w+.?){1}/u, "" ).lstrip
    end
    
    # apply leading omission if needed
    if prefix_start_index > 0 && text != self.split( //u )[0, suffix_limit].join
      text = @options[:omission] + text
    end
    
    text
  end
  
  def suffix
    text = full_text_after_substring
    
    # now only cut out the needed chars
    text = text.split( //u )[0, suffix_limit].join
    
    # now check whether to handle full words
    reverse_suffix_end_index = -( self.split( //u ).reverse.join.index( text.split( //u ).reverse.join ))
    if full_words? && 
      reverse_suffix_end_index < 0 && self.split( //u )[reverse_suffix_end_index] != " "
      
      text = text.sub( /(\w+.?){1}$/u, "" ).rstrip
    end
    
    # apply tailing omission if needed
    if reverse_suffix_end_index < 0 && text != self[-text.split( //u ).length, text.split( //u ).length]
      text += @options[:omission]
    end
    
    text
  end
  
  
  # get everything before the substring or just split in half
  def full_text_before_substring
    if include_substring?
      self.split( @substring )[0] || ""
    else
      self.split( //u )[ 0..self.split( //u ).size/2 ].join
    end
  end
  
  # get everything after the substring or just split in half
  def full_text_after_substring
    if include_substring?
      self.split( @substring )[1] || ""
    else
      self.split( //u )[ self.split( //u ).size/2+1..-1 ].join
    end
  end
  
  # the numbder of characters for the prefix
  def prefix_limit
    limit = ideal_prefix_limit
    
    # extend the limit if the text after the substring is too short
    unless @options[:prefix] || full_text_after_substring_uses_ideal_suffix_limit?
      limit += ideal_suffix_limit - full_text_after_substring.split( //u ).size
    end
    
    limit
  end
  
  # the numder of characters for the suffix
  def suffix_limit
    limit = ideal_suffix_limit
    
    # extend the limit if the text before the substring is too short
    unless @options[:suffix] || full_text_before_substring_uses_ideal_prefix_limit?
      limit += ideal_prefix_limit - full_text_before_substring.split( //u ).size
    end
    
    limit
  end
  
  
  def ideal_prefix_limit
    limit = @options[:prefix] || @options[:limit]/2
    
    if !@options[:prefix] && include_substring?
      limit -= @substring.split( //u ).size/2
    end
    
    limit
  end
  
  def ideal_suffix_limit
    limit = @options[:suffix] || @options[:limit]/2
    
    if !@options[:suffix] && include_substring?
      limit -= @substring.split( //u ).size/2
    end
    
    limit
  end
  
  # returns whether the full_text_after_substring can use the ideal_suffix_limit
  def full_text_after_substring_uses_ideal_suffix_limit?
    full_text_after_substring.split( //u ).size >= ideal_suffix_limit
  end
  
  # returns whether the full_text_after_substring can use the ideal_prefix_limit
  def full_text_before_substring_uses_ideal_prefix_limit?
    full_text_before_substring.split( //u ).size >= ideal_prefix_limit
  end
  
  
  def include_substring?
    !@substring.empty? && self.include?( @substring )
  end
  
  def full_words?; @options[:words]; end
  
end

begin
  ActionView::Helpers::TextHelper.module_eval do
    def excerpt_fu(text, phrase, *args)
      ExcerptFu.search(text, phrase, args.extract_options!)
    end
  end
rescue NameError
end
