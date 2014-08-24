require 'spec_helper'

describe 'update' do
  before { load_simple_document }

  before { 2.times { SimpleDocument.create(:field1 => 10) } }

  context 'when passing a hash of attributes' do
    it 'updates documents' do
      SimpleDocument.update_all(:field1 => 2)['replaced'].should == 2
      SimpleDocument.where(:field1 => 2).count.should == 2
    end

    it 'replaces documents' do
      doc = SimpleDocument.first
      SimpleDocument.all.limit(1).replace_all(doc.attributes.merge('field1' => 2))['replaced'].should == 1
      SimpleDocument.where(:field1 => 2).count.should == 1
    end
  end

  context 'when passing a block' do
    it 'updates documents' do
      res = SimpleDocument.update_all { |doc| {:field1 => doc[:field1] * 2} }
      res['replaced'].should == 2
      SimpleDocument.where(:field1 => 20).count.should == 2
    end
  end
end
