

var Neex = function() {
	var neex = {};
	var t_buffer = {};

	neex.load = function(a_obj,result_id){
		classe = a_obj.getAttribute("href").split("#")[1]
		if (classe!=""){
			url = "?format=json&akk="+classe
		}else{
			url = "?format=json"
		}
		neex.load_template();
		neex.render(url, result_id);
	}


	neex.load_template = function(){

			console.log("Carregando!");
			$.ajax({
				url: "/shell/actions",
				type: "get",
				dataType: "text",

				error: function(){
					console.log("ERROR!");
				},

				beforeSend: function(){
				},

				complete: function(){
				},

				success: function( raw ){
					data = tiasm_parser(raw);
					console.log(data)
					for (var i=0; i<data.box.length; i++) {
						node = data.box[i];
						obj = neex.create(node["class"])
						obj["text"] = node.text;
						obj["item"] = node.item;
					}

				}
			});

	};


	neex.create = function(class_name){
		var vetor = class_name.split(":")
		var obj = t_buffer
		for (var i=0; i<vetor.length; i++) {
			var name = vetor[i];
			if ( name in obj ){
				obj = obj[name]
			} else {
				obj[name] = {}
				obj = obj[name]
			}
		}
		return obj;
	}

	neex.enter = function(class_name){
		var vetor = class_name.split(":")
		var obj = t_buffer
		for (var i=0; i<vetor.length; i++) {
			var name = vetor[i];
			if ( name in obj ){
				obj = obj[name]
			} else {
				if ( i > 0 )
					return obj;
				else
					return null;
			}
		}
		return obj;
	}




	neex.render = function(url, result_id) {
		neex.actions("#actions");
		$.ajax({
			url: url,
			type: "get",
			dataType: "json",

			error: function(){
				$( result_id ).html( "ERRORRRR!!!!!" );
			},

			beforeSend: function(){
				$( result_id ).html( document.getElementById('neex-vt-loading').innerHTML );
			},

			complete: function(){
			},

			success: function( data ){
				var classe = data["classe"]
				var base = neex.enter(classe)
				console.log("dd")
				console.log(base)
				if ( base != null ){
					tmpl_pack = base.text;
					tmpl_item = base.item;

					str = ""
					box = data["box"]
					for (var i=0; i<box.length; i++) {
						node = box[i]
						str += Mustache.render(tmpl_item, node);
					}

					html_str = Mustache.render(tmpl_pack, {"main":str});
					$( result_id ).html( html_str );

				}
			}
		});
	};


	neex.actions = function(result_id) {

		$.ajax({
			url: "/shell/actions",
			type: "get",
			dataType: "html",

			error: function(){
				console.log("opaaaa1");
				$( result_id ).html( "ERRORRRR!!!!!" );
			},

			beforeSend: function(){
				$( result_id ).html( document.getElementById('neex-vt-loading').innerHTML );
			},

			complete: function(){
			},

			success: function( data ){
				//tiasm_parser(data);



				/*str = ""
				template = document.getElementById('link-template').innerHTML;
				for (var i=0; i<data.length; i++) {
					node = data[i]
					str += Mustache.render(template, node);
				}
				console.log( str );
				$( result_id ).html( str );*/
			}
		});
	};


	neex.form = function(class_name) {
		var options = {
			url: "/shell/forms?name="+class_name,
			title:'Novo '+class_name,
			buttons: [],
		};
		eModal.ajax(options);
	}

	return neex;
};


var neex = Neex();


function tiasm_parser(data){
	var size, attr, val, classe;

	magic = data[0] + data[1] + data[2] + data[3];
	if ( magic != "TiV1" )
		console.log("ERROR");

	adata = new Uint8Array(data);


	stack = [];
	base = {}
	obj = base;
	obj["box"] = []
	for (var i=4; i<data.length; ) {
		cmd = data[i]
		i += 2;
		console.log(cmd)
		if ( cmd == 'a' ){
			size = (data.charCodeAt(i++)&0xff) + (data.charCodeAt(i++)&0xff)*0x10 +  (data.charCodeAt(i++)&0xff)*0x100 + (data.charCodeAt(i++)&0xff)*0x1000;
			attr = data.substr(i,size-1)
			i += (size+1)&0xFFFFFFFE;

			val = (data.charCodeAt(i++)&0xff) + (data.charCodeAt(i++)&0xff)*0x10 +  (data.charCodeAt(i++)&0xff)*0x100 + (data.charCodeAt(i++)&0xff)*0x1000;


			obj[attr] = val;
			//console.log(attr+"="+val)
		} else if ( cmd == 'b' ){
			size = (data.charCodeAt(i++)&0xff) + (data.charCodeAt(i++)&0xff)*0x10 +  (data.charCodeAt(i++)&0xff)*0x100 + (data.charCodeAt(i++)&0xff)*0x1000;
			attr = data.substr(i,size-1)
			i += (size+1)&0xFFFFFFFE;

			val = (data.charCodeAt(i++)&0xff) + (data.charCodeAt(i++)&0xff)*0x10 +  (data.charCodeAt(i++)&0xff)*0x100 + (data.charCodeAt(i++)&0xff)*0x1000;

			obj[attr] = val;
			//console.log(attr+"="+val)

		} else if ( cmd == 'c' || cmd == 'd' ){
			console.log(i)
			size = (data.charCodeAt(i++)&0xff) + (data.charCodeAt(i++)&0xff)*0x10 +  (data.charCodeAt(i++)&0xff)*0x100 + (data.charCodeAt(i++)&0xff)*0x1000;
			attr = data.substr(i,size-1)
			i += (size+1)&0xFFFFFFFE;
			console.log( (size+1)&0xFFFFFFFE )
			console.log("aqui")
			console.log( data[94] * 1 )

			size = (data.charCodeAt(i++)&0xff) + (data.charCodeAt(i++)&0xff)*0x10 +  (data.charCodeAt(i++)&0xff)*0x100 + (data.charCodeAt(i++)&0xff)*0x1000;
			console.log(size)
			val  = data.substr(i,size-1)
			i += (size+1)&0xFFFFFFFE;


			obj[attr] = val;

		} else if ( cmd == 'e' ){
			size = (data.charCodeAt(i++)&0xff) + (data.charCodeAt(i++)&0xff)*0x10 +  (data.charCodeAt(i++)&0xff)*0x100 + (data.charCodeAt(i++)&0xff)*0x1000;
			attr = data.substr(i,size-1)
			i += (size+1)&0xFFFFFFFE;

			novo = {"box":[]}
			stack.push( obj )
			obj[attr] = novo;
			obj = novo
		} else if ( cmd == 'f' ){
			size = (data.charCodeAt(i++)&0xff) + (data.charCodeAt(i++)&0xff)*0x10 +  (data.charCodeAt(i++)&0xff)*0x100 + (data.charCodeAt(i++)&0xff)*0x1000;
			attr = data.substr(i,size-1)
			i += (size+1)&0xFFFFFFFE;

			size   = (data.charCodeAt(i++)&0xff) + (data.charCodeAt(i++)&0xff)*0x10 +  (data.charCodeAt(i++)&0xff)*0x100 + (data.charCodeAt(i++)&0xff)*0x1000;
			classe = data.substr(i,size-1)
			i += (size+1)&0xFFFFFFFE;

			novo = {"class":classe,"box":[]}
			obj[attr] = novo;
			stack.push( obj )
			obj = novo

		} else if ( cmd == 'g' ){
			novo = {"box":[]}

			obj["box"].push(novo);
			stack.push( obj )
			obj = novo

		} else if ( cmd == 'h' ){
			size   = (data.charCodeAt(i++)&0xff) + (data.charCodeAt(i++)&0xff)*0x10 +  (data.charCodeAt(i++)&0xff)*0x100 + (data.charCodeAt(i++)&0xff)*0x1000;
			classe = data.substr(i,size-1)
			i += (size+1)&0xFFFFFFFE;

			novo = {"class":classe,"box":[]}
			obj["box"].push(novo);
			stack.push( obj )
			obj = novo

		} else if ( cmd == 'i' ){
			//console.log(stack.length)
			if ( stack.length > 0 )
				obj = stack.pop();
			else
				obj = base
		} else {
			return {"class":"Error"};
		}

		//console.log(i)
	}
	return base;
}





function neex_searcher(input_id, result_id, url){
	extra = ""
	form = document.getElementById(input_id)
	query = form.value
	if (query != ""){
		extra +="&q="+query
	}

	akk  = ""
	aux  = window.location.href.split("#");
	if (aux.lenght > 0){
		akk = aux[1]
	}

	if (akk != ""){
		extra += "&akk="+akk
	}
	console.log("?format=json"+extra)
	neex_render("?format=json"+extra, result_id)
}



function neex_node_loader(node_id, attr_name, result_id){
	url = "/shell/?id="+node_id+"&attr="+attr_name
	neex_render(url, result_id)
}










function neex_tagit(form_id){
	obj = document.getElementById("tag_"+form_id)
alert(obj)
    obj.tagit({
        //availableTags: sampleTags,
        allowSpaces: true,
        singleField: true,
        singleFieldNode: $(form_id),

        autocomplete: {
            source: function( request, response ) {
                acAjax = $.ajax({
                    url: "/places/?format=json&query="+request.term,
                    dataType: "json",
                    data: {
                        term: request.term
                    },
                    success: function( data ) {
                        console.log(data)
                        returnedUsers = data;
                        response( $.map( data, function( item ) {
                            return {
                                label: item.name,
                                value: item.id
                            }
                        }));
                    },
                    error: function(xhr, status, error) {
                        returnedUsers = [];
                    },
                    complete: function(xhr, status, error) {

                    }
                });
            },
            minLength: 2
        },
    });
}
