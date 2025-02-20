//ScaleBarDM4 is a Fiji/ImageJ macro designed to streamline the processing of DM4 image files. This tool automates the conversion of DM4 files into TIFF format while enhancing contrast and scaling images based on pixel size metadata. Additionally, it adds scale bars to each image, ensuring consistent and accurate representation of image dimensions.

macro "ScaleBarDM4 Action Tool - C000D12D1aD1bD1cD1dD1eD22D2cD32D33D34D35D36D42D52D5cD6cD74D75D76D7cD8cD92D93D94D95D96D9cDa2Da4DacDb2Dc2Dc3Dc4Dc5Dc6Dd2Dd4DdcDe2DeaDebDecDedDeeC000C111C222C333C444C555D3cD4cDbcDccC555D72C555C666C777C888C999CaaaCbbbCcccCdddCeeeD00D01D02D03D04D05D06D07D08D09D0aD0bD0cD0dD0eD0fD10D11D13D14D15D16D17D18D19D1fD20D21D23D24D25D26D27D28D29D2aD2bD2dD2eD2fD30D31D37D38D39D3aD3bD3dD3eD3fD40D41D43D44D45D46D47D48D49D4aD4bD4dD4eD4fD50D51D53D54D55D56D57D58D59D5aD5bD5dD5eD5fD60D61D62D63D64D65D66D67D68D69D6aD6bD6dD6eD6fD70D71D73D77D78D79D7aD7bD7dD7eD7fD80D81D82D83D84D85D86D87D88D89D8aD8bD8dD8eD8fD90D91D97D98D99D9aD9bD9dD9eD9fDa0Da1Da3Da5Da6Da7Da8Da9DaaDabDadDaeDafDb0Db1Db3Db4Db5Db6Db7Db8Db9DbaDbbDbdDbeDbfDc0Dc1Dc7Dc8Dc9DcaDcbDcdDceDcfDd0Dd1Dd3Dd5Dd6Dd7Dd8Dd9DdaDdbDddDdeDdfDe0De1De3De4De5De6De7De8De9DefDf0Df1Df2Df3Df4Df5Df6Df7Df8Df9DfaDfbDfcDfdDfeDff"{
	close("*");
	dossIm = getDir("DM4 Input folder");
	
	listIm = getFileList(dossIm);
	listEnd = lengthOf(listIm);
	dossSave = dossIm+"/"+"output_Tiff_scaleBar/";
	File.makeDirectory(dossSave);
	
	for (i = 0; i < listEnd; i++) {
		imageNameTotal = File.getName(listIm[i]);
		imageName = File.getNameWithoutExtension(listIm[i]);
		testDM4 = endsWith(imageNameTotal, ".dm4");
		
		if (testDM4 == 1){
			imagi = "open="+dossIm+"/"+listIm[i];
			run("Bio-Formats Windowless Importer",imagi );
			run("Enhance Contrast", "saturated=0.35");
			run("8-bit");
			//run("Properties...", "channels=1 slices=1 frames=1 pixel_width=0.2074665 pixel_height=0.2074665 voxel_depth=1000.0000000");
			getPixelSize(unit, pixelWidth, pixelHeight);
			if (unit == "micron" || unit == "microns" || unit == "um" || unit == "µm"){
				getPixelSize(unit_origine, pixelWidth_origine, pixelHeight_origine);
				setVoxelSize(pixelWidth*1000, pixelHeight*1000, 1, "nm");
				imSize = getHeight()*pixelWidth*1000;
				//print("Taille de limage (µm) : "+ imSize/1000);
		
			}
			else if (unit == "nm" || unit == "nanometers"){
				imSize = getHeight()*pixelWidth;
				//print("Taille de limage (nm) : "+ imSize);
			}
		
			if (imSize < 800){
				//print("Scale bar de 100nm");
				scaleWidth = 100;
				}
			else if (imSize > 800 && imSize < 1600){
				//print("Scale bar de 200nm");
				scaleWidth = 200;
				}
			else if (imSize > 1600 && imSize < 3500){
				//print("Scale bar de 500nm");
				scaleWidth = 500;
				}
			else if (imSize > 3500 && imSize < 6000){
				//print("Scale bar de 1µm");
				setVoxelSize(pixelWidth_origine, pixelWidth_origine, 1, "microns");
				scaleWidth = 1;
				}
			else if (imSize > 6000 && imSize < 20000){
				//print("Scale bar de 2µm");
				setVoxelSize(pixelWidth_origine, pixelWidth_origine, 1, "microns");
				scaleWidth = 2;
				}
			else if (imSize > 20000 && imSize < 44000){
				//print("Scale bar de 5µm");
				setVoxelSize(pixelWidth_origine, pixelWidth_origine, 1, "microns");
				scaleWidth = 5;
				}
			else if (imSize >44000 && imSize < 80000){
				//print("Scale bar de 10µm");
				setVoxelSize(pixelWidth_origine, pixelWidth_origine, 1, "microns");
				scaleWidth = 10;
				}
			else if (imSize > 80000 && imSize < 210000){
				//print("Scale bar de 20µm");
				setVoxelSize(pixelWidth_origine, pixelWidth_origine, 1, "microns");
				scaleWidth = 20;
				}
			else if (imSize > 210000 && imSize <350000){
				//print("Scale bar de 50µm");
				setVoxelSize(pixelWidth_origine, pixelWidth_origine, 1, "microns");
				scaleWidth = 50;
				}
			else if (imSize > 350000){
				//print("Scale bar de 100µm");
				setVoxelSize(pixelWidth_origine, pixelWidth_origine, 1, "microns");
				scaleWidth = 100;
				}
				
			makePoint(384, 3760, "small black hybrid");
			run("Scale Bar...", "width="+scaleWidth+" height=24 font=180 color=Black background=None location=[At Selection]");	
			nameSave = dossSave+imageName+".tif";
			saveAs("Tiff", nameSave);
			close("*");
		}
	}
}


