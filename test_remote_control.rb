
# UNIT TESTING 
require "./remote_control.rb"
require "test/unit"

class TC_Remote < Test::Unit::TestCase

 # output will be 7 for these inputs '1 20','2 18 19','5 15 14 17 1 17'
 def test_case1 
  assert_equal(7,Remoteprogram.new('1 20','2 18 19','5 15 14 17 1 17').result)

 end
 # assigning output as 8 so checking the assert not equal
 def test_case1_wrong_result  
  assert_not_equal(8,Remoteprogram.new('1 20','2 18 19','5 15 14 17 1 17').result)

 end

# output will be 8 for these inputs '103 108','1 104','5 105 106 107 103 105'
def test_case2 
   assert_equal(8,Remoteprogram.new('103 108','1 104','5 105 106 107 103 105').result)
end

# output will be 12 for these inputs '1 100','4 78 79 80 3','8 10 13 13 100 99 98 77 81'
def test_case3 
   assert_equal(12,Remoteprogram.new('1 100','4 78 79 80 3','8 10 13 13 100 99 98 77 81').result)
end

# output will be 7 for these inputs '1 200','0','4 1 100 1 101'
def test_case4 
 assert_equal(7,Remoteprogram.new('1 200','0','4 1 100 1 101').result)
end
end

