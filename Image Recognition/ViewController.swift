//
//  ViewController.swift
//  Image Recognition
//
//  Created by Dmitry Novosyolov on 10/02/2019.
//  Copyright © 2019 Dmitry Novosyolov. All rights reserved.
//

import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        
        sceneView.scene = SCNScene()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let images = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil)!
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.detectionImages = images
        
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        sceneView.session.pause()
    }
    

}

extension ViewController: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let anchor = anchor as? ARImageAnchor else { return }
        
        let imageNode = getImage(for: anchor)
        node.addChildNode(imageNode)
    }
    
    func getImage(for anchor: ARImageAnchor) -> SCNNode {
        
        let image = anchor.referenceImage
        
        let size = image.physicalSize
        
        let plane = SCNPlane(width: size.width , height: size.height)
        plane.firstMaterial?.diffuse.contents = UIImage(named: "planePic")
        
        let node = SCNNode(geometry: plane)
        node.eulerAngles.x = -.pi / 2
        node.opacity = 0.5
        
        return node
    }
}

