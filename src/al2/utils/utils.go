package utils

import (
	"bufio"
	"fmt"
	"io"
	"os"
	"regexp"
	"strconv"
)

type TrainDict struct {
	Epoch     int
	TrainLoss float64
	ValidLoss float64
	TestLoss  float64
}

func SelectValue(file string) (dict []TrainDict) {
	out := make([]TrainDict, 0)
	f, err := os.Open(file)
	if err != nil {
		fmt.Println("文件打开失败=", err)
		return nil
	}
	defer f.Close()
	reader := bufio.NewReader(f)
	EpochPattern := regexp.MustCompile("Epoch: ([0-9]+)")
	trainloss := regexp.MustCompile("Train Loss: ([0-9]*.?[0-9]+)")
	valiloss := regexp.MustCompile("Vali Loss: ([0-9]*.?[0-9]+)")
	testloss := regexp.MustCompile("Test Loss: ([0-9]*.?[0-9]+)")
	for {
		str, err := reader.ReadString('\n')
		if err == io.EOF {
			break
		}
		if len(trainloss.FindStringSubmatch(str)) > 0 {
			// convert string to int

			e, _ := strconv.Atoi(EpochPattern.FindStringSubmatch(str)[1])
			t, _ := strconv.ParseFloat(trainloss.FindStringSubmatch(str)[1], 32)
			v, _ := strconv.ParseFloat(valiloss.FindStringSubmatch(str)[1], 32)
			tt, _ := strconv.ParseFloat(testloss.FindStringSubmatch(str)[1], 32)
			item := TrainDict{
				Epoch:     e,
				TrainLoss: t,
				ValidLoss: v,
				TestLoss:  tt,
			}
			out = append(out, item)
		}
	}
	return out
}
