    FactoryGirl.define do
      factory :user do
        sequence(:name)  { |n| "Person #{n}" }
        sequence(:email) { |n| "person_#{n}@example.com"}   
        password "foobar"
        password_confirmation "foobar"
    
        factory :admin do
          admin true
        end
      end
      
      factory :hunt do
        sequence(:name)  { |n| "Hunt #{n}" }        
      end
      
      factory :task do
        sequence(:name)  { |n| "Task #{n}" } 
        #sequence(:points)  {n}         
      end
           
      
    end    


