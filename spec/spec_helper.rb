$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

module ActionView
  module Helpers
    module TextHelper
    end
  end
end

class Example
  include ActionView::Helpers::TextHelper
end

require 'excerpt-fu'
require 'spec'
require 'spec/autorun'

Spec::Runner.configure do |config|
  
end
