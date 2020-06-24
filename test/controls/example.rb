# copyright: 2018, The Authors

input_deputy_id = input('deputy_id')

title "sample section"


control 'Test-001-Input' do
  impact 0.8
  tag deputy: [input_deputy_id]

  title 'Test the Input Variable'
  desc 'A test for tags and reports'
  
  describe os.family do
    it { should eq 'windows' }
  end

end