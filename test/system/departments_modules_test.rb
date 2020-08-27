require "application_system_test_case"

class DepartmentsModulesTest < ApplicationSystemTestCase
  setup do
    @departments_module = departments_modules(:one)
  end

  test "visiting the index" do
    visit departments_modules_url
    assert_selector "h1", text: "Departments Modules"
  end

  test "creating a Departments module" do
    visit departments_modules_url
    click_on "New Departments Module"

    fill_in "Departments", with: @departments_module.departments_id
    fill_in "Description", with: @departments_module.description
    fill_in "Name", with: @departments_module.name
    click_on "Create Departments module"

    assert_text "Departments module was successfully created"
    click_on "Back"
  end

  test "updating a Departments module" do
    visit departments_modules_url
    click_on "Edit", match: :first

    fill_in "Departments", with: @departments_module.departments_id
    fill_in "Description", with: @departments_module.description
    fill_in "Name", with: @departments_module.name
    click_on "Update Departments module"

    assert_text "Departments module was successfully updated"
    click_on "Back"
  end

  test "destroying a Departments module" do
    visit departments_modules_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Departments module was successfully destroyed"
  end
end
