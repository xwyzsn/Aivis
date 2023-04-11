package handler

import (
	pb "Aidemo/src/al2/proto"
	utils "Aidemo/src/al2/utils"
	"context"
	"go-micro.dev/v4/util/log"
	"gopkg.in/yaml.v3"
	"io/ioutil"
	"os"
	"os/exec"
	"strconv"
	"time"
)

type TrainError struct{}
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

var path string = "G:\\desktop\\Triformer\\Triformer"

func (e *TrainError) GetError(ctx context.Context, req *pb.TrainErrorRequest, rsp *pb.TrainErrorResponse) error {
	// TODO: 需要提供一个模型 运行结束的标志,目前还没实现
	// CORS
	id := req.GetId()
	// 这里的路径直接 在tmp下就好了
	dict := utils.SelectValue("G:\\desktop\\Aidemo" + "\\tmp" + id)
	for i := 0; i < len(dict); i++ {
		tmp := pb.TrainDict{
			Epoch:     int32(dict[i].Epoch),
			TrainLoss: float32(dict[i].TrainLoss),
			ValidLoss: float32(dict[i].ValidLoss),
			TestLoss:  float32(dict[i].TestLoss),
		}
		rsp.TrainDict = append(rsp.TrainDict, &tmp)
	}
	return nil
}

func (e *TrainError) PreTrain(ctx context.Context, req *pb.PreTrainRequest, res *pb.PreTrainResponse) error {
	// TODO: config 的类型应该从 每个算法中的 config.yaml 或者别的地方读取 ,同时proto中的message也要改。
	mode := req.GetMode()
	dataset := req.GetDataset()
	attn := req.GetAttnprob()
	freq := req.GetFreq()
	seq_len := req.GetSeqLen()
	pred_len := req.GetPredLen()
	// 这里的参数 也是有点dirty,但是暂时先这样吧
	cmd := exec.Command("python", "-u", path+"\\main.py", "--model", mode, "--data", dataset,
		"--attn", attn, "--freq", freq, "--seq_len", strconv.FormatInt(int64(seq_len), 10),
		"--pred_len", strconv.FormatInt(int64(pred_len), 10))
	cmd.Dir = path
	now := strconv.FormatInt(time.Now().Unix(), 10)
	stdout, err := os.OpenFile("./tmp"+now, os.O_CREATE|os.O_WRONLY, os.FileMode.Perm(0600))
	if err != nil {
		log.Fatal(err)
	}
	defer stdout.Close()
	cmd.Stdout = stdout
	cmd.Stderr = stdout
	res.Tid = now
	if err := cmd.Start(); err != nil {
		log.Fatal(err)
	}
	go func() {
		err := cmd.Wait()
		log.Fatal(err)
	}()
	return nil
}

func (e *TrainError) GetConfig(ctx context.Context, req *pb.ConfigRequest, res *pb.ConfigResponse) error {
	var config ModelConfig
	yamlFile, err := ioutil.ReadFile(path + "\\conf.yaml")
	if err != nil {
		log.Fatal(err)
	}
	err = yaml.Unmarshal(yamlFile, &config)
	if err != nil {
		log.Fatal(err)
	}
	// TODO: 这里的实现有点呆,可以把message中的字段改成和config中的字段一样,然后直接赋值
	res.Model = config.Model
	res.Data = config.Data
	res.RootPath = config.RootPath
	res.DataPath = config.DataPath
	res.Features = config.Features
	res.Target = config.Target
	res.Freq = config.Freq
	res.SeqLen = float64(int32(config.SeqLen))
	res.LabelLen = float64(int32(config.LabelLen))
	res.PredLen = float64(int32(config.PredLen))
	res.EncIn = float64(int32(config.EncIn))
	res.DecIn = float64(int32(config.DecIn))
	res.COut = float64(int32(config.COut))
	res.DModel = float64(int32(config.DModel))
	res.NHeads = float64(int32(config.NHeads))
	res.ELayers = float64(int32(config.ELayers))
	res.DLayers = float64(int32(config.DLayers))
	res.SLayers = make([]int32, len(config.SLayers))
	res.DFf = float64(int32(config.DFf))
	res.Factor = float64(int32(config.Factor))
	res.Padding = float64(int32(config.Padding))
	res.Distil = config.Distil
	res.Dropout = config.Dropout
	res.Attn = config.Attn
	res.Embed = config.Embed
	res.Activation = config.Activation
	res.OutputAttention = config.OutputAttention
	res.DoPredict = config.DoPredict
	res.Mix = config.Mix
	res.Cols = config.Cols
	res.NumWorkers = float64(int32(config.NumWorkers))
	res.Itr = float64(int32(config.Itr))
	res.TrainEpochs = float64(int32(config.TrainEpochs))
	res.BatchSize = float64(int32(config.BatchSize))
	res.Patience = float64(int32(config.Patience))
	res.LearningRate = config.LearningRate
	res.Des = config.Des
	res.Loss = config.Loss
	res.Lradj = config.Lradj
	res.UseAmp = config.UseAmp
	res.Inverse = config.Inverse
	res.UseGpu = config.UseGpu
	res.UseMultiGpu = config.UseMultiGpu
	res.Devices = config.Devices
	res.DetailFreq = config.DetailFreq

	return nil
}
