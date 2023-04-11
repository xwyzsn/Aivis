package main

import (
	"Aidemo/src/al2/handler"
	pb "Aidemo/src/al2/proto"
	"go-micro.dev/v4"
	"go-micro.dev/v4/logger"
	"go-micro.dev/v4/util/log"
)

func main() {
	//TODO:还有别的服务需要弄，比如gateway,因为现在我直接用的al2的服务，没有一个网关。
	// 网关需要实现的功能是，把所有的服务都注册到一个网关上，然后网关再把请求转发到对应的服务上，目前就是这里了。
	// 比如跨域？之类的，现在的实现方案是前端的 proxy
	service := micro.NewService(
		micro.Name("al2"),
		micro.Address("127.0.0.1:7900"),
	)
	// set CORS
	//service.Init(micro.WrapHandler(cors.SetHeaders(true, "Access-Control-Allow-Origin", "*")))

	service.Init()
	log.Info(service.Name())
	if err := pb.RegisterTrainErrorHandler(service.Server(), new(handler.TrainError)); err != nil {
		logger.Fatal(err)
	}

	if err := service.Run(); err != nil {
		logger.Fatal(err)
	}
}
