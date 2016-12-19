class NewAnimalForm
  include Capybara::DSL

  def visit_page
    visit('/')
    click_on('Add Animal')
    self
  end

  def fill_in_with(params = {})
    fill_in('Name', with: params.fetch(:title, 'Reksio'))
    select('Dog', from: 'Animal type')
    fill_in('Breed', with: 'White')
    choose 'Male'
    choose 'Yes'
    self
  end

  def submit
    click_on('Create Animal')
  end
end
