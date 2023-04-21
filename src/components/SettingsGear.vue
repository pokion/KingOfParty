<template>
    <img :src="gear" id="gear" />

    <div>
        
    </div>
</template>
<script>
import gear from '@/assets/gear.svg'

export default {
    setup() {
        return {
            gear
        }
    }
}
</script>
<style scoped>
    #gear{
        height: 30px;
        width: 30px;
    }
</style>