package main

import (
	"fmt"
	"go-micro.dev/v4/util/log"
	"gopkg.in/yaml.v3"
	"io/ioutil"
	"reflect"
)

type ModelConfig struct {
	Model           string  `yaml:"model"`
	Data            string  `yaml:"data"`
	RootPath        string  `yaml:"root_path"`
	DataPath        string  `yaml:"data_path"`
	Features        string  `yaml:"features"`
	Target          string  `yaml:"target"`
	Freq            string  `yaml:"freq"`
	SeqLen          int     `yaml:"seq_len"`
	LabelLen        int     `yaml:"label_len"`
	PredLen         int     `yaml:"pred_len"`
	EncIn           int     `yaml:"enc_in"`
	DecIn           int     `yaml:"dec_in"`
	COut            int     `yaml:"c_out"`
	DModel          int     `yaml:"d_model"`
	NHeads          int     `yaml:"n_heads"`
	ELayers         int     `yaml:"e_layers"`
	DLayers         int     `yaml:"d_layers"`
	SLayers         []int   `yaml:"s_layers"`
	DFf             int     `yaml:"d_ff"`
	Factor          int     `yaml:"factor"`
	Padding         int     `yaml:"padding"`
	Distil          bool    `yaml:"distil"`
	Dropout         float64 `yaml:"dropout"`
	Attn            string  `yaml:"attn"`
	Embed           string  `yaml:"embed"`
	Activation      string  `yaml:"activation"`
	OutputAttention bool    `yaml:"output_attention"`
	DoPredict       bool    `yaml:"do_predict"`
	Mix             bool    `yaml:"mix"`
	Cols            string  `yaml:"cols"`
	NumWorkers      int     `yaml:"num_workers"`
	Itr             int     `yaml:"itr"`
	TrainEpochs     int     `yaml:"train_epochs"`
	BatchSize       int     `yaml:"batch_size"`
	Patience        int     `yaml:"patience"`
	LearningRate    float64 `yaml:"learning_rate"`
	Des             string  `yaml:"des"`
	Loss            string  `yaml:"loss"`
	Lradj           string  `yaml:"lradj"`
	UseAmp          bool    `yaml:"use_amp"`
	Inverse         bool    `yaml:"inverse"`
	UseGpu          bool    `yaml:"use_gpu"`
	UseMultiGpu     bool    `yaml:"use_multi_gpu"`
	Devices         string  `yaml:"devices"`
	DetailFreq      string  `yaml:"detail_freq"`
}

func main() {
	yamlFile, err := ioutil.ReadFile("G:\\desktop\\Triformer\\Triformer\\conf.yaml")
	if err != nil {
		log.Fatal(err)
	}
	var conf ModelConfig
	err = yaml.Unmarshal(yamlFile, &conf)
	if err != nil {
		log.Fatal(err)
	}
	reflect.ValueOf("enc_id")
	fmt.Println(conf)
	fmt.Println(conf.Cols)
}
