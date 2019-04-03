//
//  ViewController.swift
//  PlaneGame
//
//  Created by user149408 on 4/3/19.
//  Copyright © 2019 user149408. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    var scene = SCNScene()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        sceneView.delegate = self
        sceneView.showsStatistics = true
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        sceneView.scene = scene
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()

        sceneView.session.run(configuration)
    }
    override func viewDidAppear(_ animated: Bool) {
        let moveAway = SCNAction.move(by:SCNVector3(0,0,-5),duration: 3)
        let moveBack = SCNAction.move(by:SCNVector3(0,0,5),duration: 3)
        let rotate180 = SCNAction.rotateBy(x: 0, y: .pi, z: 0, duration: 1)
        let flySequence = SCNAction.sequence([rotate180,moveAway,rotate180,moveBack])
        guard let baseNode = scene.rootNode.childNode(withName:"ship",recursively: true)else{return}
        scene.rootNode.addChildNode(baseNode)
        let loopSequence = SCNAction.repeatForever(flySequence)
        baseNode.runAction(loopSequence)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
