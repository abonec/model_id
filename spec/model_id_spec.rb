describe ModelId do
  before :all do
    @class_with_id = Class.new
    @class_with_id.include ModelId::Base
  end

  it 'should be a module' do
    expect(ModelId::Base).to be_a(Module)
  end

  it 'instance should have an id' do
    expect(@class_with_id.new).to respond_to(:model_id)
  end

  it 'new instance should have next id' do
    expect do
      @first_instance = @class_with_id.new
      @second_instance = @class_with_id.new
    end.to change(@class_with_id, :last_model_id).by(2)
    expect(@second_instance.model_id).to be_eql(@first_instance.model_id.next)
  end
end