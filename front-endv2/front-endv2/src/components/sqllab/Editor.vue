<template>
 <div :id="props.cid" style="border: 1px solid rgb(229 231 235);" class="w-full h-full">
    <!-- <div :id="props.cid" :style="{width:props.width+'px',height:props.height+'px'}"> -->

 </div>
 </template>
 
 <script setup>
 import {ref,onMounted,watch} from 'vue' 
 import * as monaco from 'monaco-editor/esm/vs/editor/editor.main.js';
 import editorWorker from 'monaco-editor/esm/vs/editor/editor.worker?worker';
import jsonWorker from 'monaco-editor/esm/vs/language/json/json.worker?worker';
import cssWorker from 'monaco-editor/esm/vs/language/css/css.worker?worker';
import htmlWorker from 'monaco-editor/esm/vs/language/html/html.worker?worker';
import tsWorker from 'monaco-editor/esm/vs/language/typescript/ts.worker?worker';
let textVal = ref('')
self.MonacoEnvironment = {
	getWorker(_, label) {
		if (label === 'json') {
			return new jsonWorker();
		}
		if (label === 'css' || label === 'scss' || label === 'less') {
			return new cssWorker();
		}
		if (label === 'html' || label === 'handlebars' || label === 'razor') {
			return new htmlWorker();
		}
		if (label === 'typescript' || label === 'javascript') {
			return new tsWorker();
		}
		return new editorWorker();
	}
};

let props =  defineProps({
    cid:{
        type:String,
        default:''
    },
    name:{
        type:String,
        default:''
    },
    lang:{
        type:String,
        default:'sql'
    },
    width:{
        type:Number,
        default:400
    },
    height:{
        type:Number,
        default:400
    },
    modelValue:{
        type:String,
        default:''
    }
 })
 const emit = defineEmits(['update:modelValue'])
 watch(textVal,(val,oldVal)=>{
    props.modelValue = val 
})
function updateValue(value) {
  emit('update:modelValue', value)
}
 onMounted(()=>{
    let editor = monaco.editor.create(document.getElementById(props.cid), {
        value: '\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        language: 'sql'
    });
    editor.getModel().onDidChangeContent(content=>{
        let val  = editor.getValue()
        updateValue(val)
    })

 })
</script> 
 
 <style scoped>
 
</style>