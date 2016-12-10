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

    context "is not the owner of the animal" do
      describe "DELETE" do
        it{ should_not be_able_to(:destroy, Animal.new) }
      end

      describe "GET edit animal" do
        it{ should_not be_able_to(:edit, Animal.new) }
      end

      describe "PUT update animal" do
        it { should_not be_able_to(:update, Animal.new) }
      end
    end

    context "is owner of the animal" do
      describe "DELETE animals" do
        it{ should be_able_to(:destroy, Animal.new(user: user)) }
      end

      describe "GET edit animal" do
        it{ should be_able_to(:edit, Animal.new(user: user)) }
      end

      describe "PUT update animal" do
        it{ should be_able_to(:update, Animal.new(user: user)) }
      end
    end
  end

end
