require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "ExcerptFu" do
  
  context "with given :prefix and :suffix" do
    it "should show desired number of characters altogether and place the matched substring 'in the middle'" do
      text = "An example string with substring in the middle for testing purposes"
      snippet = ExcerptFu.new(text)
      
      snippet.search("in the middle", :prefix => 6, :suffix => 6).should == "...tring in the middle for t..."
    end

    describe "when many substrings 'in the middle'" do
      it "should show desired number of characters altogether and place around first occurence of the matched substring 'in the middle'" do
        text = "An example string with substring in the middle for testing purposes with another in the middle substring"
        snippet = ExcerptFu.new(text)
        
        snippet.search("in the middle", :prefix => 6, :suffix => 6).should == "...tring in the middle for t..."
      end
    end

    describe "when not enough characters before the matched substring" do
      it "should fill the snippet with characters from 'after' the match" do
        text = "Insufficent in the middle prefix for testing purposes with another in the middle substring"
        snippet = ExcerptFu.new(text)
        
        snippet.search("in the middle", :prefix => 14, :suffix => 6).should == "Insufficent in the middle prefi..."
      end
    end

    describe "when not enough characters after the matched substring" do
      it "should fill the snippet with characters from 'before' the match" do
        text = "An example string with substring in the middle for testing"
        snippet = ExcerptFu.new(text)
        
        snippet.search("in the middle", :prefix => 6, :suffix => 14).should == "...tring in the middle for testing"
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
        
        snippet.search("in the middle", :prefix => 10, :suffix => 10).should == "...h substring in half ..."
      end
    end

    describe "when word in substring exceed the character count of desired number of" do
      it "should remove that words at start and end of the substring" do
        text = "An example string with substring in the middle for testing purposes"
        snippet = ExcerptFu.new(text)
        
        snippet.search("in the middle", :prefix => 12, :suffix => 10, :words => true).should == "...substring in the middle for..."
      end

      it "should do nothing to prefix when prefix is not cutted" do
        text = "An example string with substring in the middle for testing purposes"
        snippet = ExcerptFu.new(text)
        
        snippet.search("in the middle", :prefix => 33, :suffix => 10, :words => true).should == "An example string with substring in the middle for..."
      end

      it "should do nothing to suffix when suffix is not cutted" do
        text = "An example string with substring in the middle for testing purposes"
        snippet = ExcerptFu.new(text)
        
        snippet.search("in the middle", :prefix => 12, :suffix => 21, :words => true).should == "...substring in the middle for testing purposes"
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
  end
  
  context "with given :limit" do
    it "should return no more than characters number specified as limit" do
      text = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Vivamus vitae risus vitae lorem iaculis placerat. Aliquam sit amet felis. Etiam congue. Donec risus risus, pretium ac, tincidunt eu, tempor eu, SUBSTRING Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Vivamus vitae risus vitae lorem iaculis placerat. Aliquam sit amet felis. Etiam congue. Donec risus risus, pretium ac, tincidunt eu, tempor eu, quam. Morbi blandit mollis magna. function_label_eur_1 Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Vivamus vitae risus vitae lorem iaculis placerat. Aliquam sit amet felis. Etiam congue. Donec risus risus, pretium ac, tincidunt eu, tempor eu, quam. Morbi blandit mollis magna. Suspendisse eu tortor. Donec vitae city_label_eur_1 Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Vivamus vitae risus vitae lorem iaculis placerat. Aliquam sit amet felis. Etiam congue. Donec risus risus, pretium ac, tincidunt eu, tempor eu, quam. Morbi blandit mollis magna. Suspendis
|| se eu tortor. Donec vitae felis nec ligula blandit rhoncus."
      snippet = ExcerptFu.new(text)
      
      snippet.search("SUBSTRING", :limit => 200, :words => true, :omission => '').size.should <= 200
    end

    it "should return proper string when set limit" do
      text = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Vivamus vitae risus vitae lorem iaculis placerat. Aliquam sit amet felis. Etiam congue. Donec risus risus, pretium ac, tincidunt eu, tempor eu, SUBSTRING Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Vivamus vitae risus vitae lorem iaculis placerat. Aliquam sit amet felis. Etiam congue. Donec risus risus, pretium ac, tincidunt eu, tempor eu, quam. Morbi blandit mollis magna. function_label_eur_1 Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Vivamus vitae risus vitae lorem iaculis placerat. Aliquam sit amet felis. Etiam congue. Donec risus risus, pretium ac, tincidunt eu, tempor eu, quam. Morbi blandit mollis magna. Suspendisse eu tortor. Donec vitae city_label_eur_1 Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Vivamus vitae risus vitae lorem iaculis placerat. Aliquam sit amet felis. Etiam congue. Donec risus risus, pretium ac, tincidunt eu, tempor eu, quam. Morbi blandit mollis magna. Suspendis
|| se eu tortor. Donec vitae felis nec ligula blandit rhoncus."
      snippet = ExcerptFu.new(text)
      
      snippet.search("SUBSTRING", :limit => 200, :words => true).should == "...Aliquam sit amet felis. Etiam congue. Donec risus risus, pretium ac, tincidunt eu, tempor eu, SUBSTRING Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Vivamus vitae risus vitae lorem..."
    end

    it "should return proper string when set limit with SUBSTRING at beginning of text" do
      text = "SUBSTRING Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Vivamus vitae risus vitae lorem iaculis placerat. Aliquam sit amet felis. Etiam congue. Donec risus risus, pretium ac, tincidunt eu, tempor eu,  Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Vivamus vitae risus vitae lorem iaculis placerat. Aliquam sit amet felis. Etiam congue. Donec risus risus, pretium ac, tincidunt eu, tempor eu, quam. Morbi blandit mollis magna. function_label_eur_1 Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Vivamus vitae risus vitae lorem iaculis placerat. Aliquam sit amet felis. Etiam congue. Donec risus risus, pretium ac, tincidunt eu, tempor eu, quam. Morbi blandit mollis magna. Suspendisse eu tortor. Donec vitae city_label_eur_1 Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Vivamus vitae risus vitae lorem iaculis placerat. Aliquam sit amet felis. Etiam congue. Donec risus risus, pretium ac, tincidunt eu, tempor eu, quam. Morbi blandit mollis magna. Suspendis se eu tortor. Donec vitae felis nec ligula blandit rhoncus."
      snippet = ExcerptFu.new(text)
      
      snippet.search("SUBSTRING", :limit => 200, :words => true).should == "SUBSTRING Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Vivamus vitae risus vitae lorem iaculis placerat. Aliquam sit amet felis. Etiam congue. Donec risus risus, pretium ac, tincidunt eu,..."
    end

    it "should return proper string when set limit with SUBSTRING at end of text" do
      text = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Vivamus vitae risus vitae lorem iaculis placerat. Aliquam sit amet felis. Etiam congue. Donec risus risus, pretium ac, tincidunt eu, tempor eu,  Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Vivamus vitae risus vitae lorem iaculis placerat. Aliquam sit amet felis. Etiam congue. Donec risus risus, pretium ac, tincidunt eu, tempor eu, quam. Morbi blandit mollis magna. function_label_eur_1 Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Vivamus vitae risus vitae lorem iaculis placerat. Aliquam sit amet felis. Etiam congue. Donec risus risus, pretium ac, tincidunt eu, tempor eu, quam. Morbi blandit mollis magna. Suspendisse eu tortor. Donec vitae city_label_eur_1 Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Vivamus vitae risus vitae lorem iaculis placerat. Aliquam sit amet felis. Etiam congue. Donec risus risus, pretium ac, tincidunt eu, tempor eu, quam. Morbi blandit mollis magna. Suspendis se eu tortor. Donec vitae felis nec ligula blandit rhoncus. SUBSTRING"
      snippet = ExcerptFu.new(text)
      
      snippet.search("SUBSTRING", :limit => 200, :words => true).should == "...sit amet felis. Etiam congue. Donec risus risus, pretium ac, tincidunt eu, tempor eu, quam. Morbi blandit mollis magna. Suspendis se eu tortor. Donec vitae felis nec ligula blandit rhoncus. SUBSTRING"
    end

    it "should return proper string when set limit with SUBSTRING is near the beginning" do
      text = "Lorem ipsum dolor sit SUBSTRING amet, consectetuer adipiscing elit. Vivamus vitae risus vitae lorem iaculis placerat. Aliquam sit amet felis. Etiam congue. Donec risus risus, pretium ac, tincidunt eu, tempor eu,  Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Vivamus vitae risus vitae lorem iaculis placerat. Aliquam sit amet felis. Etiam congue. Donec risus risus, pretium ac, tincidunt eu, tempor eu, quam. Morbi blandit mollis magna. function_label_eur_1 Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Vivamus vitae risus vitae lorem iaculis placerat. Aliquam sit amet felis. Etiam congue. Donec risus risus, pretium ac, tincidunt eu, tempor eu, quam. Morbi blandit mollis magna. Suspendisse eu tortor. Donec vitae city_label_eur_1 Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Vivamus vitae risus vitae lorem iaculis placerat. Aliquam sit amet felis. Etiam congue. Donec risus risus, pretium ac, tincidunt eu, tempor eu, quam. Morbi blandit mollis magna. Suspendis se eu tortor. Donec vitae felis nec ligula blandit rhoncus."
      snippet = ExcerptFu.new(text)
      
      snippet.search("SUBSTRING", :limit => 200, :words => true).should == "Lorem ipsum dolor sit SUBSTRING amet, consectetuer adipiscing elit. Vivamus vitae risus vitae lorem iaculis placerat. Aliquam sit amet felis. Etiam congue. Donec risus risus, pretium ac, tincidunt eu,..."
    end

    it "should return proper string when set limit with SUBSTRING is near the end" do
      text = "Lorem ipsum dolor sit  amet, consectetuer adipiscing elit. Vivamus vitae risus vitae lorem iaculis placerat. Aliquam sit amet felis. Etiam congue. Donec risus risus, pretium ac, tincidunt eu, tempor eu,  Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Vivamus vitae risus vitae lorem iaculis placerat. Aliquam sit amet felis. Etiam congue. Donec risus risus, pretium ac, tincidunt eu, tempor eu, quam. Morbi blandit mollis magna. function_label_eur_1 Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Vivamus vitae risus vitae lorem iaculis placerat. Aliquam sit amet felis. Etiam congue. Donec risus risus, pretium ac, tincidunt eu, tempor eu, quam. Morbi blandit mollis magna. Suspendisse eu tortor. Donec vitae city_label_eur_1 Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Vivamus vitae risus vitae lorem iaculis placerat. Aliquam sit amet felis. Etiam congue. Donec risus risus, pretium ac, tincidunt eu, tempor eu, quam. Morbi blandit mollis magna. Suspendis se eu tortor. Donec SUBSTRING vitae felis nec ligula blandit rhoncus."
      snippet = ExcerptFu.new(text)
      
      snippet.search("SUBSTRING", :limit => 200, :words => true).should == "...sit amet felis. Etiam congue. Donec risus risus, pretium ac, tincidunt eu, tempor eu, quam. Morbi blandit mollis magna. Suspendis se eu tortor. Donec SUBSTRING vitae felis nec ligula blandit rhoncus."
    end
    
    it "should return proper string when SUBSTRING does not exist" do
      text = "Lorem ipsum dolor sit  amet, consectetuer adipiscing elit. Vivamus vitae risus vitae lorem iaculis placerat. Aliquam sit amet felis. Etiam congue. Don"
      snippet = ExcerptFu.new(text)
      
      snippet.search("SUBSTRING", :limit => 100, :omission => '').should == "t, consectetuer adipiscing elit. Vivamus vitae risus vitae lorem iaculis placerat. Aliquam sit amet "
    end

    it "should return proper string when full words requested and SUBSTRING does not exist" do
      text = "Lorem ipsum dolor sit  amet, consectetuer adipiscing elit. Vivamus vitae risus vitae lorem iaculis placerat. Aliquam sit amet felis. Etiam congue. Don"
      snippet = ExcerptFu.new(text)
      
      snippet.search("SUBSTRING", :limit => 100, :omission => '', :words => true).should == "consectetuer adipiscing elit. Vivamus vitae risus vitae lorem iaculis placerat. Aliquam sit amet"
    end
    
    it "should split correctly for multibyte characters" do
      text = "IñTëRNâTIôNàLIZæTIøN is âWëSøMæ"
      snippet = ExcerptFu.new(text)
      
      snippet.search("is", :limit => 14).should == "...æTIøN is âWëSø..."
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
