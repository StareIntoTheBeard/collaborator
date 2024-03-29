require 'spec_helper'

describe "tasks/new" do
  before(:each) do
    assign(:task, stub_model(Task,
      :name => "MyString",
      :time => "9.99",
      :description => "MyText",
      :active => false
    ).as_new_record)
  end

  it "renders new task form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tasks_path, :method => "post" do
      assert_select "input#task_name", :name => "task[name]"
      assert_select "input#task_time", :name => "task[time]"
      assert_select "textarea#task_description", :name => "task[description]"
      assert_select "input#task_active", :name => "task[active]"
    end
  end
end
