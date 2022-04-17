require 'eth'

class UsersController < ApplicationController
  # instantiate a new user
  def new
    @user = User.new
  end

  # create a new user based on user input
  def create # rubocop:disable Metrics/MethodLength, Metrics/PerceivedComplexity,  Metrics/AbcSize
    # create new user from allowed params
    @user = User.new(user_params)

    # only proceed with pretty names
    if @user && @user.username && @user.username.present?

      # create randome nonce
      @user.eth_nonce = SecureRandom.uuid

      # usually, we want to let the user sign the nonce to make sure
      # they are authorized to create a new user account for the
      # given ethereum address. for the demo, we skip this for the
      # sake of keeping it simple.

      # only proceed with eth address
      if @user.eth_address

        # make sure the eth address is valid
        address = Eth::Address.new @user.eth_address
        if address.valid?

          # save to database
          if @user.save! # rubocop:disable Metrics/BlockNesting

            # if user is created, congratulations, send them to login
            redirect_to login_path, notice: I18n.t('users.successfully_created_an_account_you_may_now_log_in')
          else

            # if it fails, eth address is already in database, go to login
            redirect_to login_path, alert: I18n.t('users.account_already_exists_try_to_log_in_instead')
          end
        else

          # if it fails, the eth address is not valid, stay on signup
          flash.now[:alert] = 'Invalid Ethereum address!'
          render :new
        end
      else

        # if it fails, the process was interupted, stay on signup
        flash.now[:alert] = 'Failed to get Ethereum address!'
        render :new
      end
    else

      # if it fails, the user did not specify a name, stay on signup
      flash.now[:alert] = 'Please choose a name (length > 0)!'
      render :new
    end
  end

  private

    def user_params
      # only allow user to control name, message, signature, and address
      params.require(:user).permit(:username, :eth_address)
    end
end
