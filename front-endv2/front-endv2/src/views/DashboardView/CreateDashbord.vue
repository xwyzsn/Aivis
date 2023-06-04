<template>
    <div class="w-full h-full">
        <div class="w-full h-full grid grid-cols-8">
            <div class=" col-span-6 bg-red-200">

            </div>
            <div class=" col-span-2 bg-slate-200">

            </div>
        </div>

        <!-- <div class="bg-red-200   resize-drag">
            <p>hello</p>
        </div> -->
    </div>
</template>
 
<script setup>
import { ref, onMounted } from 'vue'
import interact from 'interactjs'
onMounted(() => {
    const position = { x: 0, y: 0 }

    interact('.resize-drag')
        .resizable({
            // resize from all edges and corners
            edges: { left: true, right: true, bottom: true, top: true },

            listeners: {
                move(event) {
                    var target = event.target
                    var x = (parseFloat(target.getAttribute('data-x')) || 0)
                    var y = (parseFloat(target.getAttribute('data-y')) || 0)

                    // update the element's style
                    target.style.width = event.rect.width + 'px'
                    target.style.height = event.rect.height + 'px'

                    // translate when resizing from top or left edges
                    x += event.deltaRect.left
                    y += event.deltaRect.top
                    // x = position.x
                    // y = position.y
                    position.x += event.deltaRect.left
                    position.y += event.deltaRect.top
                    target.style.transform = 'translate(' + x + 'px,' + y + 'px)'

                    target.setAttribute('data-x', position.x)
                    target.setAttribute('data-y', position.y)
                }
            },
            modifiers: [
                // keep the edges inside the parent
                interact.modifiers.restrictEdges({
                    outer: 'parent'
                }),

                // minimum size
                interact.modifiers.restrictSize({
                    min: { width: 100, height: 50 }
                })
            ],

            inertia: true
        })
        .draggable({
            listeners: {
                start(event) {
                    console.log(event.type, event.target)
                },
                move(event) {
                    position.x += event.dx
                    position.y += event.dy

                    event.target.style.transform =
                        `translate(${position.x}px, ${position.y}px)`
                },
            }
        })

})

</script> 
 
<style scoped>
.resize-drag {
    width: 120px;
    border-radius: 8px;
    padding: 20px;
    margin: 1rem;
    background-color: #29e;
    color: white;
    font-size: 20px;
    font-family: sans-serif;

    touch-action: none;

    /* This makes things *much* easier */
    box-sizing: border-box;
}
</style>