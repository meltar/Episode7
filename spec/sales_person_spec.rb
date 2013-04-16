require_relative "../lib/sales_person"
require_relative "../lib/calculates_route"

describe SalesPerson do
  it "should have many cities" do
    city = stub
    subject.schedule_city(city)
    subject.cities.should include(city)
  end

  it "should keep the cities only scheduled once" do	
    city = stub
    expect{
      subject.schedule_city(city)
      subject.schedule_city(city)
    }.to change(subject.cities,:count).by(1) 			
  end

  it "should find a city using a name entered by the user" do
    city = stub
    city.stub(name:"Atlanta, GA")
    subject.schedule_city(city)
    subject.find_city("Atlanta, GA").should eq(city)
  end

  it "should calculate a route via the CalculatesRoute" do
    start = stub(name: "Atlanta, GA")
    last = stub(name: "Marietta, GA")
    cities = [start, last]
    subject.stub(:cities) { cities } 
    CalculatesRoute.should_receive(:calculate).with(cities, start)
    subject.route("Atlanta, GA")
  end

  it "should return the route from CalculatesRoute" do
    route_stub = [stub("Marietta, GA"), stub("Atlanta, GA")]
    start = stub("Marietta, GA")
    CalculatesRoute.stub(:calculate) { route_stub }
    CalculatesRoute.stub(:route).and_return(route_stub)
    subject.route(start).should eq(route_stub)
  end

end
