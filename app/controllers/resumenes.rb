Resumenes::App.controllers :resumenes do
  
  get :index do
    @resumenes = Resumenes.all
    render 'job_offers/search'
  end  

  get :new do
    @job_offer = JobOffer.new
    render 'job_offers/new'
  end

  get :latest do
    @resumenes = Resumenes.all
    render 'resumenes/list'
  end

  get :apply, :with =>:offer_id  do
    @job_offer = JobOffer.get(params[:offer_id])
    # ToDo: validate the current user is the owner of the offer
    render 'job_offers/apply'
  end

  post :create do
    @job_offer = JobOffer.new(params[:job_offer])
    @job_offer.owner = current_user
    if @job_offer.save
      flash[:success] = 'Offer created'
      redirect '/job_offers/my'
    else
      flash.now[:error] = 'Title is mandatory'
      render 'job_offers/new'
    end  
  end

  post :update, :with => :offer_id do
    @job_offer = JobOffer.get(params[:offer_id])
    @job_offer.update(params[:job_offer])
    if @job_offer.save
      flash[:success] = 'Offer updated'
      redirect '/job_offers/my'
    else
      flash.now[:error] = 'Title is mandatory'
      render 'job_offers/edit'
    end  
  end


end
