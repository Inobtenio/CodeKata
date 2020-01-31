require 'digest'

class BloomFilter

	def initialize word_dictionary, bitmap_length, hash_iterations
		@word_dictionary = word_dictionary
		@bitmap_length = bitmap_length
		@bitmap = Array(false)*bitmap_length
		@hash_iterations = hash_iterations

		set_bitmap
	end

	def include? word
		all_set_at?(generate_hashes_for(word))
	end

	private

	def all_set_at? indexes
		@bitmap.values_at(*indexes).all?
	end

	def set_bitmap
		@word_dictionary.each { |word| include_in_bitmap(word) }
	end

	def include_in_bitmap word
		generate_hashes_for(word).each { |index| @bitmap[index] = true }
	end

	def generate_hashes_for word
		hash_a = Digest::MD5.hexdigest(word).to_i(16)
		hash_b = Digest::RMD160.hexdigest(word).to_i(16)

		Array.new(@hash_iterations) { |i| index_from_hashes(hash_a, hash_b, i) }
	end

	def index_from_hashes hash_a, hash_b, factor
		### Simulating n hashing functions from just two
		### http://citeseer.ist.psu.edu/viewdoc/download?doi=10.1.1.152.579&rep=rep1&type=pdf
		(hash_a + hash_b * (factor + 1)) % @bitmap_length
	end
end