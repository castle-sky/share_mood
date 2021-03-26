require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

	def setup
		@user = User.new(name: 'jack', email: 'jack@example.com',
										password: 'foobar', password_confirmation: 'foobar')
	end

	test 'user should be valid' do
		assert @user.valid?
	end

	test 'name should be presence' do
		@user.name = '  '
		assert_not @user.valid?
	end

	test 'email should be presence' do
		@user.email = '   '
		assert_not @user.valid?
	end

	test 'name should not be too long' do
		@user.name = 'a' * 21
		assert_not @user.valid?
	end

	test 'email should not be too long' do
		@user.email = 'a' * 101
		assert_not @user.valid?
	end

	test 'email should not be invalid format' do
		invalid_emails = ['hello.kitty', 'hello.@', 'hello@.com']
		invalid_emails.each do |email|
			@user.email = email
			assert_not @user.valid?, "#{email.inspect} is not valid email"
		end
	end

	test 'email should be unique' do 
		dup_user = @user.dup
		@user.save
		assert_not dup_user.valid?
	end

	test 'email should transform to downcase before stored' do
		mixed_email = 'asJK@dd.com'
		@user.email = mixed_email
		@user.save
		assert mixed_email.downcase == @user.reload.email
	end
	test 'password should be presence' do
		@user.password = @user.password_confirmation = ' ' * 6
		assert_not @user.valid?
	end
	test 'password should not be short' do
		@user.password = @user.password_confirmation = '2' * 5
		assert_not @user.valid?
	end
	test 'password should be same as password_confirmation' do
		@user.password = 'barfoo'
		@user.password_confirmation = 'bazfoo'
		assert_not @user.valid?
	end
end
