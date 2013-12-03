require 'spec_helper'

describe "topics/edit" do
  before(:each) do
    @topic = assign(:topic, stub_model(Topic,
      :name => "MyString",
      :description => "MyString",
      :last_poster_id => 1
    ))
  end

  it "renders the edit topic form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", topic_path(@topic), "post" do
      assert_select "input#topic_name[name=?]", "topic[name]"
      assert_select "input#topic_description[name=?]", "topic[description]"
      assert_select "input#topic_last_poster_id[name=?]", "topic[last_poster_id]"
    end
  end
end
