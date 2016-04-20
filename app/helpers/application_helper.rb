module ApplicationHelper
	def flash_message
		messages = ""
		[:notice, :info, :warning, :danger].each {|type|
			if flash[type]
				messages += "<div role=\"alert\" class=\"alert-#{type}\">#{flash[type]}</div>".html_safe
			end
		}
		return messages
	end


	def link_neex(name, classe, dst="#main")
		return "<a href=\"##{classe}\" onclick=\"neex.load(this,'#{dst}')\">#{name}</a>".html_safe
	end


	def link_neex_node(name, node_id, attr_name, dst="#main")
		return "<a href=\"##{attr_name}\" onclick=\"neex_loader('#{node_id}','#{attr_name}','#{dst}')\">#{name}</a>".html_safe
	end

	def link_modal(name, class_name)
		return "<a href=\"#\" onclick=\"neex.form('#{class_name}')\">#{name}</a>".html_safe
	end
end
