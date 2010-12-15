require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

require 'benchmark'

describe "Preformance" do

  it "should search in a reasonable time" do
    text    = 'a'*10000 + " IñTëRNâTIôNàLIZæTIøN is âWëSøMæ " + 'b'*10000
    snippet = ExcerptFu.new(text)
    
    # calculating the snippet was only around 0.089/0.090 seconds before the optimization.
    # Even though this is still really fast, it created a noticible lag when rendering pages
    # with many of those long snippets. The optimized version does this in under 0.02 seconds (usually around 0.018) --R
    Benchmark.realtime { snippet.search("is", :limit => 14) }.should < 0.02
  end
end
