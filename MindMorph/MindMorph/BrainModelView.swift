//
//  BrainModelView.swift
//  MindMorph
//
//  Created by Aman Gupta on 11/02/24.
//

import SwiftUI
import UIKit
import SceneKit

struct ViewController  {
    var scene = SCNScene(named: "Brain.dae")!
    var cameraNode = SCNNode()
    
    func start(){
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x:-1,y:2,z:10)
        scene.background.contents = UIColor(.black)
        
        //
        //        if let brainNode = scene.rootNode.childNode(withName: "Brain", recursively: true){
        //            let diffuseMaterial = SCNMaterial()
        //            diffuseMaterial.diffuse.contents = UIColor.red
        //            brainNode.geometry?.materials = [diffuseMaterial]
        //            print("DOne")
        //
        //        }
        applyTextureToAll()
    }
    
    func applyTextureToAll(){
        for childNode in scene.rootNode.childNodes{
            applyTextureToNode(childNode)
        }
    }
    
    func applyTextureToNode(_ node: SCNNode){
        let textureImage = UIImage(named:"BrainDiffuse.png")
        let diffuseMaterial = SCNMaterial()
        diffuseMaterial.diffuse.contents = textureImage
        node.geometry?.materials = [diffuseMaterial]
    }
    
    func removeTexture(){
        let diffuseMaterial = SCNMaterial()
        diffuseMaterial.diffuse.contents = UIColor.white
        for childNode in scene.rootNode.childNodes{
            childNode.geometry?.materials = [diffuseMaterial]
        }
    }
    
    func applyAnatomyTexture(){
 
        
     
    }
}
    
    struct BrainModelView: View {
        let controller = ViewController()
        var body: some View {
            ZStack{
                SceneView(scene: controller.scene, pointOfView: controller.cameraNode, options: [.allowsCameraControl], preferredFramesPerSecond: 120)
                    .onAppear{
                        controller.start()
                        
                    }
                
                HStack{
                    TabButton(text: "Simple", mainFunc: controller.applyTextureToAll)
                    TabButton(text: "Anatomy", mainFunc: controller.applyAnatomyTexture)
                    TabButton(text: "Remove", mainFunc: controller.removeTexture)
                }
                
                
            }
            .ignoresSafeArea()
        }
            
        
    }
    
    #Preview {
        BrainModelView()
    }
    
    
    struct TabButton: View{
        var text: String
        var mainFunc: () -> Void
        var body: some View{
            Button{
                mainFunc()
            }
        label:{
            Text(text)
                .foregroundColor(.black)
            
        }
        .padding()
        .background(.white)
        .cornerRadius(10)
        .offset(y:UIScreen.main.bounds.height/3)
        }
    }
