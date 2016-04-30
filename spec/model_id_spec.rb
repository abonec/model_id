describe ModelId::Base do
  before :all do
    @class_with_id = Class.new
    @class_with_id.include ModelId::Base
  end

  it 'should be a module' do
    expect(ModelId::Base).to be_a(Module)
  end

  it 'should support models with initializer with arguments' do
    class_with_custom_initialializer = Class.new
    class_with_custom_initialializer.include ModelId::Base
    class_with_custom_initialializer.send(:define_method, :initialize) {|arg1,arg2|}
    expect{class_with_custom_initialializer.new(1,2)}.not_to raise_error
  end
  it 'should support models with default initializer' do
    class_without_initializer = Class.new
    class_without_initializer.include ModelId::Base
    expect{class_without_initializer.new}.not_to raise_error
  end
  it 'should support models with noargs initializer' do
    class_with_noargs_initializer = Class.new
    class_with_noargs_initializer.include ModelId::Base
    class_with_noargs_initializer.send(:define_method, :initialize){}
    expect{class_with_noargs_initializer.new}.not_to raise_error
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

  it 'should find model instance by id' do
    first_instance = @class_with_id.new
    second_instance = @class_with_id.new
    expect(@class_with_id.find_by_id(first_instance.model_id)).to eql(first_instance)
    expect(@class_with_id.find_by_id(second_instance.model_id)).to eql(second_instance)
  end
end