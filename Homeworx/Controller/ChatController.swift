//
//  ChatController.swift
//  Homeworx
//
//  Created by Hassan Mayers on 17/11/23.
//

import UIKit
import MessageKit

class ChatController: MessagesViewController {

    // MARK: - Properties
    
    struct Message: MessageType {
        var sender: MessageKit.SenderType
        var messageId: String
        var sentDate: Date
        var kind: MessageKit.MessageKind
    }
    
    struct Sender: SenderType {
        var photoURL: String
        var senderId: String
        var displayName: String
    }
    
    private var messages = [Message]()
    private let selfSender = Sender(photoURL: "", senderId: "101", displayName: "Santiago DeLeon")

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - Helpers

    func configureUI() {
        view.backgroundColor = .white
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        messages.append(Message(sender: selfSender,
                            messageId: "1",
                            sentDate: Date(),
                                kind: .text("Hello world message")))
        
        messages.append(Message(sender: selfSender,
                            messageId: "1",
                            sentDate: Date(),
                                kind: .text("Hello man, what is up with you today in the hood off the block with your hoodie and airforce one on deck?")))
        
    }
}

extension ChatController: MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate {
    func currentSender() -> MessageKit.SenderType {
        return selfSender
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessageKit.MessagesCollectionView) -> MessageKit.MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessageKit.MessagesCollectionView) -> Int {
        return messages.count
    }
}
 
