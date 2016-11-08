class RegistrationsController < Devise::RegistrationsController

  def new
    build_resource({})
    self.resource.address = Address.new
    respond_with self.resource
  end
  private
  ADDRESS = [ :street, :street_number, :house_number, :city, :zip_code ]
  def sign_up_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation, [ address_attributes: ADDRESS ])
  end

  def account_update_params
    params.require(:user).permit(:email, :first_name, :last_name, [address_attributes: ADDRESS] ,:password, :password_confirmation, :current_password)
  end
end
