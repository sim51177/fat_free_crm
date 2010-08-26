require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/campaigns/_create.html.haml" do
  include CampaignsHelper
  
  before(:each) do
    login_and_assign
    assigns[:campaign] = Campaign.new
    assigns[:users] = [ @current_user ]
  end

  it "should render [create campaign] form" do
    view.should_receive(:render).with(hash_including(:partial => "campaigns/top_section"))
    view.should_receive(:render).with(hash_including(:partial => "campaigns/objectives"))
    view.should_receive(:render).with(hash_including(:partial => "campaigns/permissions"))

    render
    rendered.should have_tag("form[class=new_campaign]")
  end

  it "should render background info field if settings require so" do
    Setting.background_info = [ :campaign ]

    render
    rendered.should have_tag("textarea[id=campaign_background_info]")
  end

  it "should not render background info field if settings do not require so" do
    Setting.background_info = []

    render
    rendered.should_not have_tag("textarea[id=campaign_background_info]")
  end
end


