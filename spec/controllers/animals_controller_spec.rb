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
      let(:animal) { FactoryGirl.create(:animal, animal_type: 3, user: user) }

      describe "DELETE animals" do
        it{ should be_able_to(:destroy, Animal.new(user: user)) }
      end

      describe "GET edit animal" do
        it{ should be_able_to(:edit, Animal.new(user: user)) }
      end

      describe "PUT update animal" do
        it{ should be_able_to(:update, Animal.new(user: user)) }
      end

      context "valid data" do
        let(:valid_data) { FactoryGirl.attributes_for(:animal, name: 'Maniek', user: user) }

        it "redirect to animals#show" do
          put :update, id: animal, animal: valid_data
          expect(response).to redirect_to(animal)
        end

        it "updates animal in the database" do
          put :update, id: animal, animal: valid_data
          animal.reload
          expect(animal.name).to eq('Maniek')
        end
      end

      context "invalid data" do
        let(:invalid_data) { FactoryGirl.attributes_for(:animal, name: '', breed: 'White') }

        it "renders :edit template" do
          put :edit, id: animal, animal: invalid_data
          expect(response).to render_template(:edit)
        end

        it "doesn't update animal in the database" do
          put :edit, id: animal, animal: invalid_data
          animal.reload
          expect(animal.breed).not_to eq('White')
        end
      end
    end

    context "is not the owner of the animal" do
      let(:animal) { FactoryGirl.create(:animal, animal_type: 3, user: user) }
      let(:other_user) { FactoryGirl.create(:user) }
      before do
        sign_in(other_user)
      end

      describe "GET edit animal" do
        it{ should_not be_able_to(:edit, Animal.new(user: user)) }
      end

      describe "Put update animal" do
        it{ should_not be_able_to(:update, Animal.new(user: user)) }
      end

      describe "DELETE animal" do
        it{ should_not be_able_to(:destroy, Animal.new(user: user)) }
      end
    end
  end

  describe "guest user" do
    describe "GET index" do
      it "renders :index template" do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "GET new" do

      it{ should_not be_able_to(:new, Animal.new) }

      it "raise an authorization error" do
        expect{ get :new }.to raise_error(CanCan::AccessDenied)
      end
    end

    describe "POST create" do
      it{ should_not be_able_to(:create, Animal.new) }

      it "raise an authorization error" do
        expect{ post :create, animal: FactoryGirl.attributes_for(:animal) }.to raise_error(CanCan::AccessDenied)
      end
    end

    describe "PUT update" do
      it{ should_not be_able_to(:update, Animal.new) }

      it "raise an authorization error" do
        user = FactoryGirl.create(:user)
        expect{ put :update, id: FactoryGirl.create(:animal, animal_type: 3, user: user), animal: FactoryGirl.attributes_for(:animal, name: 'Maniek')}.to raise_error(CanCan::AccessDenied)
      end
    end

  end
end
