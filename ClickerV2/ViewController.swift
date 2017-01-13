//
//  ViewController.swift
//  ClickerV2
//
//  Created by Developer on 11/01/2017.
//  Copyright © 2017 BrunoYoann. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {
    
    @IBOutlet weak var monsterButton: UIButton!
    @IBOutlet weak var myGolds: UILabel!
    @IBOutlet weak var monsterHealth: UILabel!
    @IBOutlet weak var displayLevel: UILabel!
    @IBOutlet weak var buttonEnhance1: UIButton!
    @IBOutlet weak var buttonEnhance2: UIButton!
    @IBOutlet weak var autoClickEnhance: UIButton!
    @IBOutlet weak var myDamagesDone: UILabel!
    @IBOutlet weak var myFriendDamagesDone: UILabel!
    @IBOutlet weak var myAutoClicksDamages: UILabel!
    @IBOutlet weak var priceEnhance1: UILabel!
    @IBOutlet weak var priceEnhance2: UILabel!
    @IBOutlet weak var princeEnhance3: UILabel!
    @IBOutlet weak var displayDmgsDealt: UILabel!
    @IBOutlet weak var displayFriendsDmgsDealt: UILabel!
    @IBOutlet weak var displayAutoClicksDmgsDealt: UILabel!

    
    var level = 1
    var golds = 0
    var goldPerClick = 1
    var dmgPerClick = 1
    var maxHealth = 10
    var currentHealth = 10
    var priceEnhanced1 = 10
    var dmgEnhanced1 = 2
    var priceEnhanced2 = 20
    var dmgEnhanced2 = 5
    var damagesDealt = 1
    var friendDmgsDealt = 0
    var damagesAutoClick = 3
    var count = 2
    var priceEnhanced3 = 15
    var dmgEnhanced3 = 3
    var testAutoClicks = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //actualiser les données
    func update() {
        self.myGolds.text = "\(golds)"
        self.priceEnhance1.text = "\(priceEnhanced1) $"
        self.myDamagesDone.text = "+ \(dmgEnhanced1)"
        self.priceEnhance2.text = "\(priceEnhanced2) $"
        self.princeEnhance3.text = " \(priceEnhanced3) $"
        self.myFriendDamagesDone.text = "\(dmgEnhanced2)"
        self.myAutoClicksDamages.text = "\(dmgEnhanced3)"

        self.displayLevel.text = "LVL : \(self.level)"
        
        guard self.currentHealth >= 0 else {
            self.monsterHealth.text = "Vie : 0"
            return
        }
        self.monsterHealth.text = "Vie : \(currentHealth)"
    }
    
    
    //test monstre en vie
    func isAlive() -> Bool {
        if self.currentHealth > 1 {
            return true
        }
        else {
            return false
        }
    }
    
    //animation monstres au moment du click
    func transformHitMinion () {
        UIView.animate(withDuration: 0.06,animations:{
                        self.monsterButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
                       completion:{
                        _ in UIView.animate(withDuration: 0.06) {
                            self.monsterButton.transform = CGAffineTransform.identity
                        }
        })
    }
    
    
    //affichage des dégats près des monstres
    func displayDamages () {
        //mes dégats
        UIView.animate(withDuration: 0.3,
                       animations: {
                        self.displayDmgsDealt.transform = CGAffineTransform(scaleX: 3, y: 3)
            },
                       completion: {
                        _ in UIView.animate(withDuration: 0) {
                            self.displayDmgsDealt.transform = CGAffineTransform.identity
                        }
        })
        //dégats allié
        guard friendDmgsDealt > 0 else {
            return
        }
        UIView.animate(withDuration: 0.3,
                       animations: {
                        self.displayFriendsDmgsDealt.transform = CGAffineTransform(scaleX: 3, y: 3)
            },
                       completion: {
                        _ in UIView.animate(withDuration: 0) {
                            self.displayFriendsDmgsDealt.transform = CGAffineTransform.identity
                        }
        })
    }
    
    //affichage dégats autoclic
    func showAutoClicksDamages() {
        guard damagesAutoClick > 0 else {
            return
        }
        UIView.animate(withDuration: 0.6,
                       animations: {
                        self.displayAutoClicksDmgsDealt.transform = CGAffineTransform(scaleX: 5, y: 5)
            },
                       completion: {
                        _ in UIView.animate(withDuration: 0) {
                            self.displayAutoClicksDmgsDealt.transform = CGAffineTransform.identity
                        }
        })
    }
    
    //fonction dégats du clic
    func damages(){
        guard isAlive() else {
            self.maxHealth *= 2
            self.currentHealth = self.maxHealth
            self.level += 1
            self.goldPerClick += self.level
            
            switchMonsterPicture()
            return
        }
        self.currentHealth -= self.dmgPerClick
        self.currentHealth -= self.friendDmgsDealt
    }
    
    //amelioration1
    @IBAction func enhancedWeaponClick(_ sender: UIButton) {
        guard self.golds >= self.priceEnhanced1 else {
            return
        }
        self.golds -= self.priceEnhanced1
        self.priceEnhanced1 *= 2
        self.dmgPerClick += self.dmgEnhanced1
        self.dmgEnhanced1 *= 2
        self.damagesDealt = self.dmgPerClick
        self.displayDmgsDealt.text = "\(self.damagesDealt)"
        
        update()
    }
    
    //amelioration 2
    @IBAction func enhancedFriendWeapon(_ sender: UIButton) {
        guard self.golds >= self.priceEnhanced2 else {
            return
        }
        self.displayFriendsDmgsDealt.text = "\(self.dmgEnhanced2)"
        self.friendDmgsDealt = self.dmgEnhanced2
        self.golds -= self.priceEnhanced2
        self.priceEnhanced2 *= 2
        self.dmgEnhanced2 *= 2
        
        update()
    }
    
    // amelioration 3
    @IBAction func enhancedAutoClicks(_ sender: UIButton) {
        guard self.golds >= self.priceEnhanced3 else {
            return
        }
        self.damagesAutoClick = self.dmgEnhanced3
        self.displayAutoClicksDmgsDealt.text = "\(self.damagesAutoClick)"
        self.golds -= self.priceEnhanced3
        self.priceEnhanced3 *= 2
        self.dmgEnhanced3 *= 2
        
        autoClick()
        update()
    }

    //fonction dégats auto
    func damagesAutoClicks(){
        guard isAlive() else {
            self.maxHealth *= 2
            self.currentHealth = self.maxHealth
            self.level += 1
            self.goldPerClick += self.level
            
            switchMonsterPicture()
            return
        }
        self.golds += self.level
        self.currentHealth -= self.damagesAutoClick
    }
    
    //repetitions autoclics
    func autoClick() {
        guard testAutoClicks else {
            return
        }
        _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ViewController.damagesAutoClicks), userInfo: nil, repeats: true)
        _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ViewController.update), userInfo: nil, repeats: true)
        _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ViewController.showAutoClicksDamages), userInfo: nil, repeats: true)
        testAutoClicks = false
    }

    //action bouton monstres
    @IBAction func Clicked(_ sender: UIButton) {
        self.golds += self.goldPerClick
        
        damages()
        displayDamages()
        transformHitMinion()
        update()
    }
    
    // portraits monstres
    func switchMonsterPicture(){
        if let image1 = UIImage(named: "monster\(count).png"){
            monsterButton.setImage(image1, for: .normal)
            self.count += 1
        }
        else {
            self.count = 2
            monsterButton.setImage(UIImage(named: "bat.png"), for: .normal)
        }
    }
    

}

