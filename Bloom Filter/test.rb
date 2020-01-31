require_relative "bloomfilter"
require "test/unit"
 
class TestSimpleNumber < Test::Unit::TestCase

	def setup
		words_file = open("/usr/share/dict/words", "r")
		@words = words_file.read.split("\n")
		words_file.close
	end

	def test_bloom_filter
		bf = BloomFilter.new(@words, 15000000, 5)

		assert_false(bf.include? "esternocleidomastoideo")
		assert_false(bf.include? "this is looking good")
		assert_true(bf.include? "zoology")
		1000.times do |i|
			assert_false(bf.include? (i.to_s))
		end
	end

	def test_hash_lookup
		assert_false(@words.include? "esternocleidomastoideo")
		assert_false(@words.include? "taking longer than anticipated")
		assert_true(@words.include? "zoology")
		1000.times do |i|
			assert_false(@words.include? (i.to_s))
		end
	end
end
