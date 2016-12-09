require 'rails_helper'
require 'cancan/matchers'

RSpec.describe AnimalsController, type: :controller do

  describe "authenticated user" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in(user)
    end

    describe "GET index" do
      it "renders :index template" do
        get :index
        expect(response).to render_template(:index)
      end
    end

    describe "GET new" do
      it{ should be_able_to(:create, Animal.new) }
    end

    describe "not DELETE" do
      it{ should_not be_able_to(:destroy, Animal.new) }
    end

    describe "DELETE own animals" do
      it{ should be_able_to(:destroy, Animal.new(user: user)) }
    end

    describe "PUT own animal" do
      it{ should be_able_to(:edit, Animal.new(user: user)) }
    end
  end

end
