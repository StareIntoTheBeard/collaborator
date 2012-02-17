class Project < ActiveRecord::Base
	include GithubbugOctokit

	attr_accessor :issues

	has_many :assignments
	has_many :users, :through => :assignments
	has_many :labels

	after_find :auth_octokit
	after_find :get_issues

	def get_issues
		
		enabled_labels = labels.find_all_by_enabled(true) || []

   		label_list = []
	    
	    for label in enabled_labels
	      label_list << label.name
	    end

	    # debugger
	    if label_list.empty?
	      issues = []
	    else
	      issues = @octokit.issues(repo, {:labels => label_list.join(",")} )
	    end

	    issues_hash = {}
	    
	    issues.each do |issue| 
	      issue.labels.each do |label|
	        if not label_list.include?(label.name)
	          issue.labels.delete(label) 
	        end
	      end
	      issues_hash[issue.number] = issue
	    end

	    self.issues = issues_hash
	end

	def find_issue(id)
		self.issues[id.to_i]
	end

	def get_comments(issue)
		@octokit.issue_comments(repo, issue.number)
	end
	
	def update_labels(updated_labels)
      all_labels = labels.find(:all)

      for label in all_labels
        label.update_attribute(:enabled, !!updated_labels.include?(label.id.to_s))
      end
	end
end