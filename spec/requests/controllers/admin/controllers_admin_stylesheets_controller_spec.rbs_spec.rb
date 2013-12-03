require 'spec_helper'

describe "Controllers::Admin::StylesheetsControllerSpec.rbs" do
  describe "GET /controllers_admin_stylesheets_controller_spec.rbs" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get controllers_admin_stylesheets_controller_spec.rbs_path
      response.status.should be(200)
    end
  end
end
