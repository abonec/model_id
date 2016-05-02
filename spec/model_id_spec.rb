describe ModelId::Base do
  before :all do
    @class_with_id = Class.new do
      include ModelId::Base
    end
  end

  it 'should be a module' do
    expect(ModelId::Base).to be_a(Module)
  end

  it 'should support models with initializer with arguments' do
    class_with_custom_initialializer = Class.new do
      include ModelId::Base
      def initialize(arg1, arg2);
      end
    end
    expect{class_with_custom_initialializer.new(1,2)}.not_to raise_error
  end
  it 'should support models with default initializer' do
    class_without_initializer = Class.new do
      include ModelId::Base
    end
    expect{class_without_initializer.new}.not_to raise_error
  end
  it 'should support models with noargs initializer' do
    class_with_noargs_initializer = Class.new do
      include ModelId::Base
      def initialize
      end
    end
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

  it 'should delete model from index' do
    instance = @class_with_id.new
    expect(@class_with_id.find_by_id(instance.model_id)).to eql(instance)
    instance.delete_model
    expect(@class_with_id.find_by_id(instance.model_id)).to be_nil
  end
end