		require 'spec_helper'

		describe Admin::StylesheetController do

			describe '#show' do
			  let(:stylesheet) { Factory(:stylesheet) }
			  it 'should have the correct css' do
			    get :show, id: stylesheet.id
			    expect(response.body).to eq(stylesheet.code)
			  end  
			end

		end
