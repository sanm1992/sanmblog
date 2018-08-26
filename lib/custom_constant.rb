module CustomConstant
	module ConstantValue
    def const_values
      result = []
      self.constants.each {|constant_key| result << self.const_get(constant_key)}
      result
    end
  end

  # module Test
  # 	extend ConstantValue
  # 	TEST = 'test'.freeze
  # end

  module ArticleTag
    extend ConstantValue
  	GOSSIP = 'gossip'
    RUBY = 'RUBY'
    CSS = 'CSS'
    JS = 'JavaScript'
  end
end