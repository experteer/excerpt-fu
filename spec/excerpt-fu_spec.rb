require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "ExcerptFu" do

  describe "Behavioral Specs" do

    it "should show desired number of characters altogether and place the matched substring 'in the middle'" do
      text = "An example string with substring in the middle for testing purposes"
      snippet = ExcerptFu.new(text)
      snippet.search("in the middle", :prefix => 6, :suffix => 6).should == "tring in the middle for t"
    end

    describe "when many substrings 'in the middle'" do
      it "should show desired number of characters altogether and place around first occurence of the matched substring 'in the middle'" do
        text = "An example string with substring in the middle for testing purposes with another in the middle substring"
        snippet = ExcerptFu.new(text)
        snippet.search("in the middle", :prefix => 6, :suffix => 6).should == "tring in the middle for t"
      end
    end

    describe "when not enough characters before the matched substring" do
      it "should fill the snippet with characters from 'after' the match" do
        text = "Insufficent in the middle prefix for testing purposes with another in the middle substring"
        snippet = ExcerptFu.new(text)
        snippet.search("in the middle", :prefix => 14, :suffix => 6).should == "Insufficent in the middle prefix "
      end
    end

    describe "when not enough characters after the matched substring" do
      it "should fill the snippet with characters from 'before' the match" do
        text = "An example string with substring in the middle for testing"
        snippet = ExcerptFu.new(text)
        snippet.search("in the middle", :prefix => 6, :suffix => 14).should == "bstring in the middle for testing"
      end
    end

    describe "when there are not enough characters to fill the total desired number of" do
      it "should do nothing" do
        text = "Too short string in the middle for testing"
        snippet = ExcerptFu.new(text)
        snippet.search("in the middle", :prefix => 20, :suffix => 20).should == text
      end
    end

    describe "when there is no match altogether" do
      it "should split the snippet 'in half' and use desired number of characters around that" do
        text = "An example string with substring in half for testing purposes"
        snippet = ExcerptFu.new(text)
        snippet.search("in the middle", :prefix => 10, :suffix => 10).should == "th substring in half"
      end
    end

    describe "when word in substring exceed the character count of desired number of" do
      it "should remove that words at start and end of the substring" do
        text = "An example string with substring in the middle for testing purposes"
        snippet = ExcerptFu.new(text)
        snippet.search("in the middle", :prefix => 12, :suffix => 10, :words => true).should == "substring in the middle for"
      end

      it "should do nothing to prefix when prefix is not cutted" do
        text = "An example string with substring in the middle for testing purposes"
        snippet = ExcerptFu.new(text)
        snippet.search("in the middle", :prefix => 33, :suffix => 10, :words => true).should == "An example string with substring in the middle for"
      end

      it "should do nothing to suffix when suffix is not cutted" do
        text = "An example string with substring in the middle for testing purposes"
        snippet = ExcerptFu.new(text)
        snippet.search("in the middle", :prefix => 12, :suffix => 21, :words => true).should == "substring in the middle for testing purposes"
      end
    end

    it "should return the same text when suffix not exist" do
      text = "default description"
      snippet = ExcerptFu.new(text)
      snippet.search("description", :prefix => 200, :suffix => 200, :words => true).should == text
    end

    it "should return the same text when search substring not exist" do
      text = "default description"
      snippet = ExcerptFu.new(text)
      snippet.search("not existing", :prefix => 200, :suffix => 200, :words => true).should == text
    end

    it "should return no more than characters number specified as limit" do
      text = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Vivamus vitae risus vitae lorem iaculis placerat. Aliquam sit amet felis. Etiam congue. Donec risus risus, pretium ac, tincidunt eu, tempor eu, SUBSTRING Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Vivamus vitae risus vitae lorem iaculis placerat. Aliquam sit amet felis. Etiam congue. Donec risus risus, pretium ac, tincidunt eu, tempor eu, quam. Morbi blandit mollis magna. function_label_eur_1 Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Vivamus vitae risus vitae lorem iaculis placerat. Aliquam sit amet felis. Etiam congue. Donec risus risus, pretium ac, tincidunt eu, tempor eu, quam. Morbi blandit mollis magna. Suspendisse eu tortor. Donec vitae city_label_eur_1 Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Vivamus vitae risus vitae lorem iaculis placerat. Aliquam sit amet felis. Etiam congue. Donec risus risus, pretium ac, tincidunt eu, tempor eu, quam. Morbi blandit mollis magna. Suspendis
|| se eu tortor. Donec vitae felis nec ligula blandit rhoncus."
      snippet = ExcerptFu.new(text)
      snippet.search("SUBSTRING", :limit => 200, :words => true).size.should <= 200
    end

    it "should return proper string when set limit" do
      text = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Vivamus vitae risus vitae lorem iaculis placerat. Aliquam sit amet felis. Etiam congue. Donec risus risus, pretium ac, tincidunt eu, tempor eu, SUBSTRING Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Vivamus vitae risus vitae lorem iaculis placerat. Aliquam sit amet felis. Etiam congue. Donec risus risus, pretium ac, tincidunt eu, tempor eu, quam. Morbi blandit mollis magna. function_label_eur_1 Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Vivamus vitae risus vitae lorem iaculis placerat. Aliquam sit amet felis. Etiam congue. Donec risus risus, pretium ac, tincidunt eu, tempor eu, quam. Morbi blandit mollis magna. Suspendisse eu tortor. Donec vitae city_label_eur_1 Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Vivamus vitae risus vitae lorem iaculis placerat. Aliquam sit amet felis. Etiam congue. Donec risus risus, pretium ac, tincidunt eu, tempor eu, quam. Morbi blandit mollis magna. Suspendis
|| se eu tortor. Donec vitae felis nec ligula blandit rhoncus."
      snippet = ExcerptFu.new(text)
      snippet.search("SUBSTRING", :limit => 200, :words => true).should == ". Aliquam sit amet felis. Etiam congue. Donec risus risus, pretium ac, tincidunt eu, tempor eu, SUBSTRING Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Vivamus vitae risus vitae lorem"
    end

  end

  describe "Unit Specs" do
    before do
      @text_snippet = ExcerptFu.new('prefix middle suffix')
    end

    describe "self.search" do
      it "should " do
        @text_snippet.should_receive(:search).with("substring", "options").and_return("result")
        ExcerptFu.should_receive(:new).with("text").and_return(@text_snippet)
        ExcerptFu.search("text", "substring", "options").should == "result"
      end
    end

    describe "prefix" do
      before do
        @text_snippet.stub!(:full_words => true)
      end

      it "should return prefix_raw when not using full words" do
        @text_snippet.should_receive(:full_words).and_return(false)
        @text_snippet.should_receive(:prefix_raw).and_return('prefix_raw')
        @text_snippet.send(:prefix).should == 'prefix_raw'
      end

      it "should return prefix_raw when using full words but prefix first word is complete" do
        @text_snippet.should_receive(:prefix_first_word_incomplete?).and_return(false)
        @text_snippet.should_receive(:prefix_raw).and_return('prefix_raw')
        @text_snippet.send(:prefix).should == 'prefix_raw'
      end

      it "should return prefix_raw with removed first word when using full words and prefix first word is incomplete" do
        @text_snippet.should_receive(:prefix_first_word_incomplete?).and_return(true)
        @text_snippet.should_receive(:prefix_raw).and_return('test prefix_raw')
        @text_snippet.send(:prefix).should == 'prefix_raw'
      end
    end

    describe "prefix_first_word_incomplete?" do
      it "should be true when prefix start is gt 0 and first character before cutted prefix is not ' '" do
        @text_snippet.should_receive(:prefix_start).twice.and_return(1)
        @text_snippet.should_receive(:prefix_str).and_return(" test")
        @text_snippet.send(:prefix_first_word_incomplete?).should be_true
      end

      it "should be false when prefix start is 0" do
        @text_snippet.should_receive(:prefix_start).and_return(0)
        @text_snippet.send(:prefix_first_word_incomplete?).should be_false
      end

      it "should be true when prefix start is gt 0 but first character before cutted prefix is ' '" do
        @text_snippet.should_receive(:prefix_start).twice.and_return(2)
        @text_snippet.should_receive(:prefix_str).and_return(" test")
        @text_snippet.send(:prefix_first_word_incomplete?).should be_true
      end
    end

    describe "prefix_raw" do
      it "should return range of prefix string from prefix_start marker to end" do
        @text_snippet.should_receive(:prefix_start).and_return(2)
        @text_snippet.should_receive(:prefix_str).and_return(" test")
        @text_snippet.send(:prefix_raw).should == "est"
      end

      it "should return range of prefix string from prefix_start marker minus half size of substring to end when limit set" do
        @text_snippet.should_receive(:prefix_start).and_return(2)
        @text_snippet.should_receive(:prefix_str).and_return(" test")
        @text_snippet.should_receive(:limit).and_return(1)
        @text_snippet.should_receive(:substring).and_return('aa')
        @text_snippet.send(:prefix_raw).should == "st"
      end
    end

    describe "suffix" do
      before do
        @text_snippet.stub!(:full_words => true)
      end

      it "should return prefix_raw when not using full words" do
        @text_snippet.should_receive(:full_words).and_return(false)
        @text_snippet.should_receive(:suffix_raw).and_return('suffix_raw')
        @text_snippet.send(:suffix).should == 'suffix_raw'
      end

      it "should return prefix_raw when using full words but prefix first word is complete" do
        @text_snippet.should_receive(:suffix_last_word_incomplete?).and_return(false)
        @text_snippet.should_receive(:suffix_raw).and_return('suffix_raw')
        @text_snippet.send(:suffix).should == 'suffix_raw'
      end

      it "should return prefix_raw with removed first word when using full words and prefix first word is incomplete" do
        @text_snippet.should_receive(:suffix_last_word_incomplete?).and_return(true)
        @text_snippet.should_receive(:suffix_raw).and_return('suffix_raw test')
        @text_snippet.send(:suffix).should == 'suffix_raw'
      end
    end

    describe "suffix_last_word_incomplete?" do
      before do
        @text ||= "test "
      end

      it "should be true when suffix end is end of string and last character before cutted suffix is not ' '" do
        @text_snippet.should_receive(:suffix_end).twice.and_return(1)
        @text_snippet.should_receive(:suffix_str).twice.and_return(@text)
        @text_snippet.send(:suffix_last_word_incomplete?).should be_true
      end

      it "should be false when suffix end is end of string" do
        @text_snippet.should_receive(:suffix_end).and_return(@text.size)
        @text_snippet.should_receive(:suffix_str).and_return(@text)
        @text_snippet.send(:suffix_last_word_incomplete?).should be_false
      end

      it "should be true when suffix end is gt end of string but last character before cutted suffix is ' '" do
        @text_snippet.should_receive(:suffix_end).twice.and_return(2)
        @text_snippet.should_receive(:suffix_str).twice.and_return(@text)
        @text_snippet.send(:suffix_last_word_incomplete?).should be_true
      end
    end

    describe "suffix_raw" do
      it "should return range of suffix string from suffix_start marker to end" do
        @text_snippet.should_receive(:suffix_end).and_return(2)
        @text_snippet.should_receive(:suffix_str).and_return(" test")
        @text_snippet.send(:suffix_raw).should == " te"
      end

      it "should return range of suffix string from suffix_start marker to end minus half size of substring when limit set" do
        @text_snippet.should_receive(:suffix_end).and_return(2)
        @text_snippet.should_receive(:suffix_str).and_return(" test")
        @text_snippet.should_receive(:limit).and_return(1)
        @text_snippet.should_receive(:substring).and_return('aa')
        @text_snippet.send(:suffix_raw).should == " t"
      end
    end

    describe "extract_options" do
      it "should set proper attributes" do
        @text_snippet.send(:extract_options, {
          :prefix => 'prefix',
          :suffix => 'suffix',
          :words => 'words'
        })
        @text_snippet.prefix_size.should == 'prefix'
        @text_snippet.suffix_size.should == 'suffix'
        @text_snippet.full_words.should == 'words'
      end

      it "should set half of limit value for prefix and suffix when limit defined" do
        @text_snippet.should_receive(:half_of_limit).with(:limit => 'limit').twice.and_return('half_of_limit')
        @text_snippet.send(:extract_options, {
          :limit => 'limit'
        })
        @text_snippet.prefix_size.should == 'half_of_limit'
        @text_snippet.suffix_size.should == 'half_of_limit'
        @text_snippet.limit.should == 'limit'
      end
    end

    describe "half_of_limit" do
      it "should return half of limit when limit exist" do
        @text_snippet.send(:half_of_limit, :limit => 10).should == 5
      end

      it "should return nil when limit does not exist" do
        @text_snippet.send(:half_of_limit, {}).should be_nil
      end
    end

    it "prefix_start_raw should return difference between size of prefix string and prefix size from parameters" do
      @text_snippet.should_receive(:prefix_str).and_return("AA")
      @text_snippet.should_receive(:prefix_size).and_return(1)
      @text_snippet.send(:prefix_start_raw).should == 1
    end

    describe "prefix_start" do
      before do
        @text_snippet.stub!(:prefix_start_raw => 5)
      end

     it "should return prefix_start_raw whem suffix string size is gt required suffix size" do
        @text_snippet.should_receive(:suffix_str).and_return("bar")
        @text_snippet.should_receive(:suffix_size).and_return(1)
        @text_snippet.send(:prefix_start).should == 5
      end

      it "should add left characters from suffix to prefix and return" do
        @text_snippet.should_receive(:suffix_str).twice.and_return("bar")
        @text_snippet.should_receive(:suffix_size).twice.and_return(5)
        @text_snippet.send(:prefix_start).should == 3
      end
    end

    it "suffix_end_raw should return suffix_size decreased by 1" do
      @text_snippet.should_receive(:suffix_size).and_return(2)
      @text_snippet.send(:suffix_end_raw).should == 1
    end

    describe "suffix_end" do

      it "should return suffix_end_raw when prefix_start_raw is gt 0" do
        @text_snippet.should_receive(:prefix_start_raw).and_return(1)
        @text_snippet.should_receive(:suffix_end_raw).and_return('suffix_end_raw')
        @text_snippet.send(:suffix_end).should == 'suffix_end_raw'
      end

      it "should return suffix_end_raw decreased by prefix_start_raw when prefix_start_raw is 0" do
        @text_snippet.should_receive(:prefix_start_raw).twice.and_return(-1)
        @text_snippet.should_receive(:suffix_end_raw).and_return(2)
        @text_snippet.send(:suffix_end).should == 3
      end
    end

    it "prefix_str should return prefix string from main string" do
      @text_snippet.should_receive(:substring).and_return('middle')
      @text_snippet.send(:prefix_str).should == 'prefix '
    end

    it "suffix_str should return suffix string from main string" do
      @text_snippet.should_receive(:substring).and_return('middle')
      @text_snippet.send(:suffix_str).should == ' suffix'
    end

    'prefix middle suffix'

    it "middle_substring should return middle of the string" do
      @text_snippet.should_receive(:prefix_size).and_return(3)
      @text_snippet.should_receive(:suffix_size).and_return(3)
      @text_snippet.send(:middle_substring).should == 'middle'
    end

  end

end

describe "ExcerptFu Rails Support" do
  Array.class_eval do
    def extract_options!
      last.is_a?(::Hash) ? pop : {}
    end
  end

  it "should add helper to Rails ActionView::Helpers::TextHelper" do
    example = Example.new
    args = {:example => 'option'}
    ExcerptFu.should_receive(:search).with("text", "phrase", args).and_return("result")
    example.excerpt_fu("text", "phrase", args).should == "result"
  end
end
