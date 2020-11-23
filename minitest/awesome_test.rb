# https://github.com/seattlerb/minitest
require 'minitest/autorun'
# We will require minitest, We will use autorun and it will load minitest class and will run automatically as a test and we don't have to worry about its

class AwesomeTest < MiniTest::Test

    # Name of the method the method should begin with 'test_'
# def test_something
#     assert_equal(2,1+1+1)
# end

class Vector

    attr_accessor :x, :y, :z
  
    def initialize(x,y,z)
      @x = x
      @y = y
      @z = z
    end
  
    def magnitude
      (x ** 2 + y ** 2 + z ** 2) ** (1.0 / 2.0)
    end
  
    def plus(vector)
      # Vector.new(x + vector.x + 1, y + vector.y + 1, z + vector.z + 1) 
      Vector.new(x + vector.x, y + vector.y, z + vector.z)
    end
  
    def minus(vector)
      # Vector.new(x - vector.x - 1, y - vector.y - 1, z - vector.z - 1)
      Vector.new(x - vector.x, y - vector.y, z - vector.z)
    end
  end

#   describe is a method provided by mintest to organize our test
# This is a test suite for Vactor Class
describe Vector do
    # This describe is provide description regarding the .magnitude method of Vector Class
    describe ".magnitude" do
        # it() method is also provided by minitest
        it 'calculate and return the magnitude(length) of the vector' do
            # Given
            # Given is a new instance of a vector. This it the initial state before test
            vector=Vector.new(3,7, 4)

            # When
            # The scenario or the function that you want to test
            length = vector.magnitude

            # Then
            # The state of the program after the behaviour

            # _ is a method in minitest . Pass it the value to assert.
            _(length).must_equal(8.602325267042627)
        end



    end

    describe ".plus" do
        it "return an instance of a vector" do
            # Given
            # Instance of two vectors
            vector_1=Vector.new(3,7,4)
            vector_2=Vector.new(3,7,4)

            #When
            added_vector=vector_1.plus(vector_2)

            # Then
            _(added_vector).must_be_kind_of(Vector)

        end
        it "calculates the correct vector" do
            # Given
            vector_1=Vector.new(3,7,4)
            vector_2=Vector.new(3,7,4)

            #When
            added_vector=vector_1.plus(vector_2)
            
            # Then
            _(added_vector.x).must_equal(6)
            _(added_vector.y).must_equal(14)
            _(added_vector.z).must_equal(8)

            
        end

    end




end

end

