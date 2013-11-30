require 'spec_helper'

describe "ResumenesController" do


        describe 'get :ver_resumen' do
		
	  it 'debe enviar resumenes/lista' do
	  	Resumenes::App.any_instance.should_receive(:render).with('resumenes/ver')
	  	get '/resumenes/ver'
	  end

	 end 
end
